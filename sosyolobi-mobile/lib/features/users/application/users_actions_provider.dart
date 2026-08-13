import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/users_api.dart';
import '../domain/report.dart';

part 'users_actions_provider.g.dart';

/// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
/// actions, no cached query state to invalidate.
@riverpod
class UserActionsController extends _$UserActionsController {
  @override
  FutureOr<void> build() {}

  Future<void> block(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(usersApiProvider).block(userId));
  }

  Future<void> report({required String reportedUserId, required String reason, String? details}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(usersApiProvider).report(
            CreateReportRequest(reportedUserId: reportedUserId, reason: reason, details: details),
          ),
    );
  }
}
