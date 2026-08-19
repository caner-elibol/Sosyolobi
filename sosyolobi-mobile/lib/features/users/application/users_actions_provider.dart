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

  /// See `RequestActionsController._run`'s doc — same autoDispose-mid-flight
  /// fix (`ref.keepAlive()` for the mutation's duration).
  Future<void> _run(Future<void> Function() action) async {
    final keepAliveLink = ref.keepAlive();
    state = const AsyncLoading();
    try {
      state = await AsyncValue.guard(action);
    } finally {
      keepAliveLink.close();
    }
  }

  Future<void> block(String userId) => _run(() => ref.read(usersApiProvider).block(userId));

  Future<void> report({required String reportedUserId, required String reason, String? details}) => _run(() async {
        await ref.read(usersApiProvider).report(
              CreateReportRequest(reportedUserId: reportedUserId, reason: reason, details: details),
            );
        ref.invalidate(myReportsProvider);
      });
}
