import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/utils/category_icons.dart';
import '../../../activities/domain/activity.dart';
import 'activity_preview_sheet.dart';
import 'cluster_breakdown_sheet.dart';

const _openFreeMapStyle = 'https://tiles.openfreemap.org/styles/liberty';

/// A group of nearby [ActivityMapItem]s collapsed into a single marker.
/// `items.length == 1` renders as a normal pin; more than that renders as a
/// cluster bubble showing a per-category breakdown on tap.
class _MarkerGroup {
  _MarkerGroup(this.items)
      : center = LatLng(
          items.map((i) => i.latitude).reduce((a, b) => a + b) / items.length,
          items.map((i) => i.longitude).reduce((a, b) => a + b) / items.length,
        );

  final List<ActivityMapItem> items;
  final LatLng center;

  Map<String, int> get categoryCounts {
    final map = <String, int>{};
    for (final item in items) {
      map[item.categoryName] = (map[item.categoryName] ?? 0) + 1;
    }
    return map;
  }
}

/// The live, interactive map — activity markers, user-location dot,
/// marker-tap preview, and grid-based client-side clustering (item 3).
/// Extracted out of `MapScreen` so the exact same widget runs both as the
/// (removed) small preview and full-screen in [MapExploreScreen].
///
/// Markers use the annotation API (`addCircle`/`addCircles`/`addSymbol`,
/// `onCircleTapped`/`onSymbolTapped`) rather than a GeoJSON source + native
/// clustering layers. The source/layer approach was tried first (matching
/// web's `supercluster` config) and every call succeeded with zero
/// exceptions — confirmed via instrumented logging — but never visually
/// rendered on this plugin/Android combination; native clustering silently
/// no-ops for runtime-added sources here. Individual annotation circles
/// render reliably (proven by the user-location dot, which uses the same
/// API and always worked), so clustering here is computed client-side (a
/// simple lat/lng grid bucketed by zoom level — collapses to one group per
/// item at high zoom) and rendered as annotations, same as before.
class ActivityMapCanvas extends StatefulWidget {
  const ActivityMapCanvas({
    required this.initialCenter,
    required this.userLocation,
    required this.items,
    required this.onActivityTap,
    this.initialZoom = 12.5,
    super.key,
  });

  final LatLng initialCenter;
  final LatLng userLocation;
  final List<ActivityMapItem> items;
  final ValueChanged<ActivityMapItem> onActivityTap;
  final double initialZoom;

  @override
  State<ActivityMapCanvas> createState() => ActivityMapCanvasState();
}

class ActivityMapCanvasState extends State<ActivityMapCanvas> {
  MapLibreMapController? _controller;
  bool _ready = false;
  double _zoom = 12.5;

  Circle? _userLocationDot;
  Circle? _userLocationPulseRing;
  Timer? _pulseTimer;
  double _pulsePhase = 0;

  List<Circle> _markerCircles = [];
  List<Symbol> _clusterLabels = [];
  Map<String, _MarkerGroup> _groupsByMarkerKey = {};

  String? _selectedActivityId;

  @override
  void initState() {
    super.initState();
    _zoom = widget.initialZoom;
  }

  @override
  void didUpdateWidget(covariant ActivityMapCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _rebuildMarkers();
    }
    if (oldWidget.userLocation != widget.userLocation) {
      _updateUserLocationMarker(widget.userLocation);
    }
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  /// Recenters on the user's current location — exposed for an explicit
  /// "my location" control in [MapExploreScreen].
  Future<void> recenterOnUser() async {
    await _controller?.animateCamera(CameraUpdate.newLatLng(widget.userLocation));
  }

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString: _openFreeMapStyle,
      initialCameraPosition: CameraPosition(target: widget.initialCenter, zoom: widget.initialZoom),
      myLocationEnabled: false,
      onMapCreated: (controller) {
        _controller = controller;
        controller.onCircleTapped.add(_handleCircleTapped);
        controller.onSymbolTapped.add(_handleSymbolTapped);
      },
      onStyleLoadedCallback: () async {
        _ready = true;
        await _updateUserLocationMarker(widget.userLocation);
        await _rebuildMarkers();
      },
      onCameraIdle: _handleCameraIdle,
    );
  }

  void _handleCameraIdle() {
    final zoom = _controller?.cameraPosition?.zoom;
    if (zoom == null) return;
    // Only re-cluster on a real zoom change — panning at the same zoom
    // doesn't change grid membership enough to matter and would otherwise
    // flicker markers on every pan.
    if ((zoom - _zoom).abs() < 0.4) return;
    _zoom = zoom;
    _rebuildMarkers();
  }

  // ── User location: bigger filled dot + a pulsing outer ring ────────────

  Future<void> _updateUserLocationMarker(LatLng point) async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_userLocationPulseRing == null) {
      _userLocationPulseRing = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 14,
          circleColor: '#2563EB',
          circleOpacity: 0.28,
        ),
      );
      _startPulseAnimation();
    } else {
      await controller.updateCircle(_userLocationPulseRing!, CircleOptions(geometry: point));
    }

    if (_userLocationDot == null) {
      _userLocationDot = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 11,
          circleColor: '#2563EB',
          circleStrokeWidth: 3,
          circleStrokeColor: '#ffffff',
        ),
      );
    } else {
      await controller.updateCircle(_userLocationDot!, CircleOptions(geometry: point));
    }
  }

  void _startPulseAnimation() {
    _pulseTimer?.cancel();
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 60), (_) async {
      final controller = _controller;
      final ring = _userLocationPulseRing;
      if (controller == null || ring == null || !mounted) return;
      _pulsePhase = (_pulsePhase + 0.035) % 1.0;
      final radius = 12 + _pulsePhase * 20; // 12 -> 32
      final opacity = (1 - _pulsePhase) * 0.45;
      await controller.updateCircle(ring, CircleOptions(circleRadius: radius, circleOpacity: opacity));
    });
  }

  // ── Activity pins + clustering ──────────────────────────────────────────

  /// Grid cell size in degrees at [zoom] — bigger cells (more aggressive
  /// clustering) when zoomed out, shrinking to "no clustering" once zoomed
  /// in far enough that individual pins are already spaced apart. Tuned by
  /// feel rather than a precise px-radius conversion (unlike web's
  /// `supercluster`, there's no pixel-accurate projection available here
  /// without an async round-trip per point).
  double _gridSizeDegrees(double zoom) {
    if (zoom >= 15) return 0;
    if (zoom >= 13) return 0.01;
    if (zoom >= 11.5) return 0.03;
    if (zoom >= 10) return 0.08;
    if (zoom >= 8) return 0.2;
    if (zoom >= 6) return 0.6;
    return 1.5;
  }

  List<_MarkerGroup> _cluster(List<ActivityMapItem> items, double zoom) {
    final grid = _gridSizeDegrees(zoom);
    if (grid <= 0) return [for (final item in items) _MarkerGroup([item])];

    final buckets = <String, List<ActivityMapItem>>{};
    for (final item in items) {
      final key = '${(item.latitude / grid).round()}_${(item.longitude / grid).round()}';
      buckets.putIfAbsent(key, () => []).add(item);
    }
    return [for (final bucket in buckets.values) _MarkerGroup(bucket)];
  }

  Future<void> _rebuildMarkers() async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_markerCircles.isNotEmpty) {
      await controller.removeCircles(_markerCircles);
      _markerCircles = [];
    }
    if (_clusterLabels.isNotEmpty) {
      await controller.removeSymbols(_clusterLabels);
      _clusterLabels = [];
    }

    final groups = _cluster(widget.items, _zoom);
    _groupsByMarkerKey = {};
    if (groups.isEmpty) return;

    final circleOptions = <CircleOptions>[];
    final circleData = <Map<String, dynamic>>[];
    final symbolOptions = <SymbolOptions>[];
    final symbolData = <Map<String, dynamic>>[];

    for (var i = 0; i < groups.length; i++) {
      final group = groups[i];
      final key = 'g$i';
      _groupsByMarkerKey[key] = group;

      if (group.items.length == 1) {
        final item = group.items.single;
        final isSelected = item.id == _selectedActivityId;
        circleOptions.add(
          CircleOptions(
            geometry: group.center,
            // Bigger, more tappable pins — was a flat 9px radius regardless
            // of selection; selected pin now grows further so tap feedback
            // is visible (item 3).
            circleRadius: isSelected ? 19 : 13,
            circleColor: _hexColor(CategoryIcons.colorFor(item.categoryName)),
            circleStrokeWidth: isSelected ? 3 : 2,
            circleStrokeColor: '#ffffff',
          ),
        );
        circleData.add({'type': 'activity', 'markerKey': key});
      } else {
        final count = group.items.length;
        final radius = count >= 50 ? 26.0 : (count >= 10 ? 22.0 : 18.0);
        circleOptions.add(
          CircleOptions(
            geometry: group.center,
            circleRadius: radius,
            circleColor: '#081B4B',
            circleStrokeWidth: 3,
            circleStrokeColor: '#ffffff',
            circleOpacity: 0.92,
          ),
        );
        circleData.add({'type': 'cluster', 'markerKey': key});
        symbolOptions.add(
          SymbolOptions(
            geometry: group.center,
            textField: '$count',
            textSize: count >= 10 ? 14 : 13,
            textColor: '#ffffff',
          ),
        );
        symbolData.add({'type': 'cluster', 'markerKey': key});
      }
    }

    _markerCircles = await controller.addCircles(circleOptions, circleData);
    if (symbolOptions.isNotEmpty) {
      _clusterLabels = await controller.addSymbols(symbolOptions, symbolData);
    }
  }

  String _hexColor(Color color) => '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  void _handleCircleTapped(Circle circle) {
    final data = circle.data;
    if (data == null) return; // the user-location dot/ring has no `data` — ignore its taps.
    _handleMarkerTapped(data);
  }

  void _handleSymbolTapped(Symbol symbol) {
    final data = symbol.data;
    if (data == null) return;
    _handleMarkerTapped(data);
  }

  void _handleMarkerTapped(Map<String, dynamic> data) {
    final markerKey = data['markerKey'] as String?;
    final group = markerKey == null ? null : _groupsByMarkerKey[markerKey];
    if (group == null || !mounted) return;

    if (group.items.length == 1) {
      _openActivitySheet(group.items.single);
    } else {
      _openClusterSheet(group);
    }
  }

  void _openActivitySheet(ActivityMapItem item) {
    setState(() => _selectedActivityId = item.id);
    _rebuildMarkers();
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ActivityPreviewSheet(
        item: item,
        onGoToActivity: () {
          Navigator.of(context).pop();
          widget.onActivityTap(item);
        },
      ),
    ).whenComplete(() {
      if (!mounted) return;
      setState(() => _selectedActivityId = null);
      _rebuildMarkers();
    });
  }

  void _openClusterSheet(_MarkerGroup group) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ClusterBreakdownSheet(
        categoryCounts: group.categoryCounts,
        totalCount: group.items.length,
        onZoomIn: () {
          Navigator.of(context).pop();
          _controller?.animateCamera(CameraUpdate.newLatLngZoom(group.center, math.min(_zoom + 2.5, 17)));
        },
      ),
    );
  }
}
