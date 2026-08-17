import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/users_api.dart';
import '../domain/report.dart';

part 'users_actions_provider.g.dart';

/// "Raporlarım" — the current user's own submitted reports with status.
/// Mirrors `ReportsController.GetMine` (`GET /api/reports/mine`, new
/// 2026-08-15). No existing mobile flow surfaced this before; added here
/// since a report-submission flow (`ReportUserDialog`) already exists.
@riverpod
Future<List<ReportResponse>> myReports(Ref ref) async {
  final page = await ref.watch(usersApiProvider).getMyReports();
  return page.items;
}

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
    ref.invalidate(myReportsProvider);
  }
}
