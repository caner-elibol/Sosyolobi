import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart' show LatLng;

import '../../../core/domain/enums.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../activities/application/categories_provider.dart';
import '../application/map_activities_provider.dart';
import 'widgets/activity_map_canvas.dart';
import 'widgets/filter_chips.dart';
import 'widgets/map_filter_dropdowns.dart';

/// Full-screen, stable version of the map — pushed from [MapScreen]'s
/// "Haritayı Büyüt" button (the small embedded preview is intentionally
/// non-interactive; a live map inside that screen's scrolling list lost its
/// markers on scroll). Has its own "küçült" (collapse/back) control to
/// return to the list, per explicit request.
class MapExploreScreen extends ConsumerStatefulWidget {
  const MapExploreScreen({
    required this.initialCenter,
    required this.userLocation,
    this.initialCategoryId,
    this.initialRadiusMeters = 10000,
    this.initialGenderPreference,
    this.initialIsFree,
    super.key,
  });

  final LatLng initialCenter;
  final LatLng userLocation;
  final String? initialCategoryId;
  final int initialRadiusMeters;
  final GenderPreference? initialGenderPreference;
  final bool? initialIsFree;

  @override
  ConsumerState<MapExploreScreen> createState() => _MapExploreScreenState();
}

class _MapExploreScreenState extends ConsumerState<MapExploreScreen> {
  final _canvasKey = GlobalKey<ActivityMapCanvasState>();
  late String? _categoryId = widget.initialCategoryId;
  late int _radiusMeters = widget.initialRadiusMeters;
  late GenderPreference? _genderPreference = widget.initialGenderPreference;
  late bool? _isFree = widget.initialIsFree;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final mapActivitiesAsync = ref.watch(
      mapActivitiesProvider(
        latitude: widget.userLocation.latitude,
        longitude: widget.userLocation.longitude,
        radiusMeters: _radiusMeters,
        categoryId: _categoryId,
        genderPreference: _genderPreference,
        isFree: _isFree,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ActivityMapCanvas(
              key: _canvasKey,
              initialCenter: widget.initialCenter,
              userLocation: widget.userLocation,
              items: mapActivitiesAsync.valueOrNull ?? const [],
              initialZoom: 13,
              onActivityTap: (item) => context.push(RoutePaths.activityDetail(item.id)),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      _RoundIconButton(icon: Icons.arrow_back, onTap: () => Navigator.of(context).pop()),
                      const Spacer(),
                      if (mapActivitiesAsync.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  categoriesAsync.maybeWhen(
                    data: (categories) => FilterChipsRow(
                      categories: categories,
                      selected: _categoryId,
                      onSelect: (id) => setState(() => _categoryId = id),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  MapFilterDropdownsRow(
                    radiusMeters: _radiusMeters,
                    onRadiusChanged: (v) => setState(() => _radiusMeters = v),
                    gender: _genderPreference,
                    onGenderChanged: (v) => setState(() => _genderPreference = v),
                    isFree: _isFree,
                    onIsFreeChanged: (v) => setState(() => _isFree = v),
                  ),
                ],
              ),
            ),
          ),
          if (mapActivitiesAsync.hasError)
            Positioned(
              left: 16,
              right: 16,
              bottom: 90,
              child: Material(
                color: AppColors.destructiveBg,
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    mapActivitiesAsync.error is ApiException ? (mapActivitiesAsync.error! as ApiException).message : 'Etkinlikler yüklenemedi.',
                    style: const TextStyle(color: AppColors.destructive),
                  ),
                ),
              ),
            ),
          Positioned(
            right: 16,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: _RoundIconButton(
                icon: Icons.my_location,
                onTap: () => _canvasKey.currentState?.recenterOnUser(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20, color: AppColors.foreground),
        ),
      ),
    );
  }
}
