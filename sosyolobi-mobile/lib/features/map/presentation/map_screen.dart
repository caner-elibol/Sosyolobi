import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart' show LatLng;

import '../../../core/domain/category.dart';
import '../../../core/domain/enums.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../activities/application/categories_provider.dart';
import '../application/current_location_provider.dart';
import '../application/map_activities_provider.dart';
import '../domain/current_location.dart';
import 'map_explore_screen.dart';
import 'widgets/filter_chips.dart';
import 'widgets/location_permission_card.dart';
import 'widgets/map_filter_dropdowns.dart';
import 'widgets/map_preview_card.dart';
import 'widgets/create_activity_promo_card.dart';
import 'widgets/nearby_activity_card.dart';

/// Ports `sosyolobi-web-2/src/app/(user)/app/map/page.tsx`'s **mobile**
/// layout specifically (`show-mobile` branch: small map box + scrollable
/// "Yakındaki Etkinlikler" feed) — not the desktop split-panel layout.
///
/// The map box here is a static (non-interactive) preview, not a live
/// `MapLibreMap` — embedding the real platform view inside this screen's
/// scrolling `ListView` made it lose its rendered markers on scroll and
/// never recover (confirmed live). Tapping the preview (or its "Haritayı
/// Büyüt" button) opens [MapExploreScreen], the real interactive map,
/// full-screen and outside any scrollable ancestor — with its own "küçült"
/// control to return here.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  String? _selectedCategoryId;
  int _radiusMeters = 10000;
  GenderPreference? _genderPreference;
  bool? _isFree;

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationNotifierProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      body: SafeArea(
        child: locationAsync.when(
          data: (location) => _buildContent(location, categoriesAsync),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                error is ApiException ? error.message : 'Konum alınamadı.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(CurrentLocation location, AsyncValue<List<Category>> categoriesAsync) {
    final mapActivitiesAsync = ref.watch(
      mapActivitiesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        radiusMeters: _radiusMeters,
        categoryId: _selectedCategoryId,
        genderPreference: _genderPreference,
        isFree: _isFree,
      ),
    );

    final userLatLng = LatLng(location.latitude, location.longitude);
    final showPermissionCard = location.isFallback && location.permissionState != LocationPermissionState.deniedForever;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        categoriesAsync.maybeWhen(
          data: (categories) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FilterChipsRow(
              categories: categories,
              selected: _selectedCategoryId,
              onSelect: (id) => setState(() => _selectedCategoryId = id),
            ),
          ),
          orElse: () => const SizedBox(height: 44),
        ),
        MapFilterDropdownsRow(
          radiusMeters: _radiusMeters,
          onRadiusChanged: (v) => setState(() => _radiusMeters = v),
          gender: _genderPreference,
          onGenderChanged: (v) => setState(() => _genderPreference = v),
          isFree: _isFree,
          onIsFreeChanged: (v) => setState(() => _isFree = v),
        ),
        if (showPermissionCard)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: LocationPermissionCard(
              onAllow: () => ref.read(currentLocationNotifierProvider.notifier).refresh(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MapPreviewCard(
            activityCount: mapActivitiesAsync.valueOrNull?.length,
            onExpand: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MapExploreScreen(
                  initialCenter: userLatLng,
                  userLocation: userLatLng,
                  initialCategoryId: _selectedCategoryId,
                  initialRadiusMeters: _radiusMeters,
                  initialGenderPreference: _genderPreference,
                  initialIsFree: _isFree,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Yakındaki Etkinlikler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              mapActivitiesAsync.maybeWhen(
                data: (items) => Text('${items.length} etkinlik', style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        mapActivitiesAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EmptyStateWidget(
                  icon: Icons.location_off_outlined,
                  title: 'Yakında etkinlik bulunamadı',
                  description: 'Arama yarıçapını artırın veya filtre kaldırın.',
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (final item in items) ...[
                    NearbyActivityCard(item: item, onTap: () => context.push(RoutePaths.activityDetail(item.id))),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            );
          },
          loading: () => const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
          error: (error, stack) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              error is ApiException ? error.message : 'Etkinlikler yüklenemedi.',
              style: const TextStyle(color: AppColors.destructive),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: CreateActivityPromoCard(onTap: () => context.push(RoutePaths.activityCreate)),
        ),
      ],
    );
  }
}
