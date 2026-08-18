import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/theme/colors.dart';
import '../../auth/application/auth_notifier.dart';
import '../application/current_location_provider.dart';
import '../domain/current_location.dart';

/// Mandatory gate shown right after login, before any /app/* route is
/// reachable — `app_router.dart`'s redirect sends every authenticated user
/// here until [currentLocationNotifierProvider] resolves to `granted`.
///
/// Watching the provider here triggers the OS permission prompt immediately
/// on first arrival (`CurrentLocationNotifier.build()` requests permission
/// as a side effect). If the user denies, they can retry or fall back to
/// signing out — Sosyolobi has no useful "no location" experience, so there
/// is no skip button here (unlike `LocationPermissionCard`'s dismissible
/// in-map nudge, which predates this gate and now only matters for the rare
/// case permission is revoked mid-session).
class LocationGateScreen extends ConsumerWidget {
  const LocationGateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(currentLocationNotifierProvider);
    final permissionState = locationAsync.valueOrNull?.permissionState;
    final isLoading = locationAsync.isLoading && permissionState == null;
    final deniedForever =
        permissionState == LocationPermissionState.deniedForever;
    final denied = permissionState == LocationPermissionState.denied;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoftBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.place,
                  color: AppColors.accentSoftFg,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isLoading ? 'Konum bilgisi alınıyor...' : 'Konum İzni Gerekli',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isLoading
                    ? 'Bir saniye bekleyin.'
                    : deniedForever
                    ? 'Yakındaki etkinlikleri gösterebilmemiz için konum iznini ayarlardan açman gerekiyor.'
                    : 'Sosyolobi\'yi kullanabilmek için konumuna erişim izni vermen gerekiyor. Bu izin olmadan devam edemeyiz.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mutedForeground,
                ),
              ),
              const SizedBox(height: 32),
              if (isLoading)
                const CircularProgressIndicator()
              else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (deniedForever) {
                        Geolocator.openAppSettings();
                      } else {
                        ref
                            .read(currentLocationNotifierProvider.notifier)
                            .refresh();
                      }
                    },
                    child: Text(
                      deniedForever
                          ? 'Ayarları Aç'
                          : (denied ? 'Tekrar Dene' : 'Konum İzni Ver'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        ref.read(authNotifierProvider.notifier).logout(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.destructive,
                    ),
                    icon: const Icon(Icons.logout, size: 16),
                    label: const Text('Çıkış Yap'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
