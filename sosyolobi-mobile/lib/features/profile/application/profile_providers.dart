import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/profile_api.dart';
import '../domain/profile.dart';

part 'profile_providers.g.dart';

/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
@Riverpod(keepAlive: true)
class MyProfile extends _$MyProfile {
  @override
  Future<UserProfile> build() => ref.watch(profileApiProvider).getMe();

  Future<void> updateProfile({required String displayName, String? bio}) async {
    final updated = await ref.read(profileApiProvider).update(displayName: displayName, bio: bio);
    state = AsyncData(updated);
  }

  Future<void> uploadAvatar(String filePath) async {
    final updated = await ref.read(profileApiProvider).uploadAvatar(filePath);
    state = AsyncData(updated);
  }
}

/// Mirrors `usePublicProfile`.
@riverpod
Future<PublicProfile> publicProfile(Ref ref, String userId) => ref.watch(profileApiProvider).getPublic(userId);
