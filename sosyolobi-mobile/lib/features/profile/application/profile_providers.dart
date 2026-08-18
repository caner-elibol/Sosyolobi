import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_notifier.dart';
import '../data/profile_api.dart';
import '../domain/profile.dart';

part 'profile_providers.g.dart';

/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
///
/// `keepAlive: true` means this never auto-disposes, so without watching
/// [authNotifierProvider] it would keep serving the FIRST user's profile
/// forever — logging out and back in as a different user (without fully
/// restarting the app) showed the previous account's name/avatar on the
/// Profile screen, since nothing ever re-triggered `getMe()`. Watching auth
/// state here mirrors [NotificationHub]'s already-correct pattern, so this
/// rebuilds (and refetches) on every login/logout, not just the first one.
@Riverpod(keepAlive: true)
class MyProfile extends _$MyProfile {
  @override
  Future<UserProfile> build() async {
    await ref.watch(authNotifierProvider.future);
    return ref.watch(profileApiProvider).getMe();
  }

  Future<void> updateProfile({required String displayName, String? bio}) async {
    final updated = await ref
        .read(profileApiProvider)
        .update(displayName: displayName, bio: bio);
    state = AsyncData(updated);
  }

  Future<void> uploadAvatar(String filePath) async {
    final updated = await ref.read(profileApiProvider).uploadAvatar(filePath);
    state = AsyncData(updated);
  }
}

/// Mirrors `usePublicProfile`.
@riverpod
Future<PublicProfile> publicProfile(Ref ref, String userId) =>
    ref.watch(profileApiProvider).getPublic(userId);
