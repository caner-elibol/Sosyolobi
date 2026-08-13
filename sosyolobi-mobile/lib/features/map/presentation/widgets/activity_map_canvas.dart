import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/utils/category_icons.dart';
import '../../../activities/domain/activity.dart';
import 'activity_preview_sheet.dart';

const _openFreeMapStyle = 'https://tiles.openfreemap.org/styles/liberty';

/// The live, interactive map — activity markers, user-location dot,
/// marker-tap preview. Extracted out of `MapScreen` so the exact same widget
/// runs both as the (removed) small preview and full-screen in
/// [MapExploreScreen].
///
/// Markers use the annotation API (`addCircle`/`addCircles`,
/// `onCircleTapped`) rather than a GeoJSON source + native clustering
/// layers. The source/layer approach was tried first (matching web's
/// `supercluster` config) and every call succeeded with zero exceptions —
/// confirmed via instrumented logging — but never visually rendered on this
/// plugin/Android combination; native clustering silently no-ops for
/// runtime-added sources here. Individual annotation circles render
/// reliably (proven by the user-location dot, which uses the same API and
/// always worked), so markers are unclustered for now. Revisit true
/// clustering only if this plugin/version combination changes.
///
/// Also never placed inside a scrolling ancestor for real use — a
/// `MapLibreMap` platform view embedded in a `ListView` loses its rendered
/// markers on scroll (confirmed live). [MapScreen] uses a static preview
/// instead and opens this widget full-screen via [MapExploreScreen].
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

  Circle? _userLocationCircle;
  List<Circle> _activityCircles = [];
  Map<String, ActivityMapItem> _itemsById = {};

  @override
  void didUpdateWidget(covariant ActivityMapCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _updateActivityMarkers(widget.items);
    }
    if (oldWidget.userLocation != widget.userLocation) {
      _updateUserLocationMarker(widget.userLocation);
    }
  }

  @override
  void dispose() {
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
      },
      onStyleLoadedCallback: () async {
        _ready = true;
        await _updateUserLocationMarker(widget.userLocation);
        await _updateActivityMarkers(widget.items);
      },
    );
  }

  Future<void> _updateUserLocationMarker(LatLng point) async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_userLocationCircle == null) {
      _userLocationCircle = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 8,
          circleColor: '#2563EB',
          circleStrokeWidth: 3,
          circleStrokeColor: '#ffffff',
        ),
      );
    } else {
      await controller.updateCircle(_userLocationCircle!, CircleOptions(geometry: point));
    }
  }

  Future<void> _updateActivityMarkers(List<ActivityMapItem> items) async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_activityCircles.isNotEmpty) {
      await controller.removeCircles(_activityCircles);
      _activityCircles = [];
    }

    _itemsById = {for (final item in items) item.id: item};
    if (items.isEmpty) return;

    final options = [
      for (final item in items)
        CircleOptions(
          geometry: LatLng(item.latitude, item.longitude),
          circleRadius: 9,
          circleColor: _hexColor(CategoryIcons.colorFor(item.categoryName)),
          circleStrokeWidth: 2,
          circleStrokeColor: '#ffffff',
        ),
    ];
    final data = [for (final item in items) {'id': item.id}];

    _activityCircles = await controller.addCircles(options, data);
  }

  String _hexColor(Color color) => '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  void _handleCircleTapped(Circle circle) {
    final id = circle.data?['id'] as String?;
    if (id == null) return; // the user-location dot has no `data` — ignore its taps.
    final item = _itemsById[id];
    if (item == null || !mounted) return;

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ActivityPreviewSheet(
        item: item,
        onGoToActivity: () {
          Navigator.of(context).pop();
          widget.onActivityTap(item);
        },
      ),
    );
  }
}
