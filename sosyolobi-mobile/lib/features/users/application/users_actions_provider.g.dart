// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myReportsHash() => r'4cfc5f943bfc6cae19d4dfc176eb39797f91e3b2';

/// "Raporlarım" — the current user's own submitted reports with status.
/// Mirrors `ReportsController.GetMine` (`GET /api/reports/mine`, new
/// 2026-08-15). No existing mobile flow surfaced this before; added here
/// since a report-submission flow (`ReportUserDialog`) already exists.
///
/// Copied from [myReports].
@ProviderFor(myReports)
final myReportsProvider =
    AutoDisposeFutureProvider<List<ReportResponse>>.internal(
      myReports,
      name: r'myReportsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myReportsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyReportsRef = AutoDisposeFutureProviderRef<List<ReportResponse>>;
String _$userActionsControllerHash() =>
    r'cc27ad9916d9631611419b0ada580cec0a740414';

/// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
/// actions, no cached query state to invalidate.
///
/// Copied from [UserActionsController].
@ProviderFor(UserActionsController)
final userActionsControllerProvider =
    AutoDisposeAsyncNotifierProvider<UserActionsController, void>.internal(
      UserActionsController.new,
      name: r'userActionsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userActionsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserActionsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
