import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../activities/domain/activity.dart';
import '../data/friends_api.dart';
import '../domain/friend.dart';

part 'friends_providers.g.dart';

/// Mirrors `useFriends` in `sosyolobi-web-2/src/hooks/useFriends.ts`.
@riverpod
Future<List<Friend>> friends(Ref ref) => ref.watch(friendsApiProvider).getFriends();

/// Mirrors `useIncomingFriendRequests`.
@riverpod
Future<List<FriendRequest>> incomingFriendRequests(Ref ref) => ref.watch(friendsApiProvider).getIncomingRequests();

/// Mirrors `useSentFriendRequests`.
@riverpod
Future<List<FriendRequest>> sentFriendRequests(Ref ref) => ref.watch(friendsApiProvider).getSentRequests();

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".
@riverpod
Future<List<Activity>> friendActivities(Ref ref, String userId) => ref.watch(friendsApiProvider).getFriendActivities(userId);

enum FriendStatus { none, pendingSent, pendingIncoming, friends }

class FriendStatusInfo {
  const FriendStatusInfo({required this.status, this.request, this.isLoading = false});

  final FriendStatus status;
  final FriendRequest? request;
  final bool isLoading;
}

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.
@riverpod
FriendStatusInfo friendStatus(Ref ref, String userId) {
  final friendsAsync = ref.watch(friendsProvider);
  final sentAsync = ref.watch(sentFriendRequestsProvider);
  final incomingAsync = ref.watch(incomingFriendRequestsProvider);

  final friendsList = friendsAsync.value ?? const <Friend>[];
  final matchedFriend = friendsList.where((f) => f.user.userId == userId).firstOrNull;
  if (matchedFriend != null) {
    return const FriendStatusInfo(status: FriendStatus.friends);
  }

  final sentList = sentAsync.value ?? const <FriendRequest>[];
  final sentRequest = sentList.where((r) => r.user.userId == userId).firstOrNull;
  if (sentRequest != null) {
    return FriendStatusInfo(status: FriendStatus.pendingSent, request: sentRequest);
  }

  final incomingList = incomingAsync.value ?? const <FriendRequest>[];
  final incomingRequest = incomingList.where((r) => r.user.userId == userId).firstOrNull;
  if (incomingRequest != null) {
    return FriendStatusInfo(status: FriendStatus.pendingIncoming, request: incomingRequest);
  }

  final isLoading = friendsAsync.isLoading || sentAsync.isLoading || incomingAsync.isLoading;
  return FriendStatusInfo(status: FriendStatus.none, isLoading: isLoading);
}

/// Mirrors the mutations in `useFriends.ts` — grouped into one action
/// controller (like `RequestActionsController`) since they all invalidate
/// the same friend-list/request-list caches.
@riverpod
class FriendActionsController extends _$FriendActionsController {
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

  Future<void> sendRequest(String addresseeUserId) => _run(() async {
        await ref.read(friendsApiProvider).sendRequest(addresseeUserId);
        ref.invalidate(sentFriendRequestsProvider);
        ref.invalidate(friendStatusProvider(addresseeUserId));
      });

  Future<void> accept(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).accept(requestId);
        ref.invalidate(incomingFriendRequestsProvider);
        ref.invalidate(friendsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> reject(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).reject(requestId);
        ref.invalidate(incomingFriendRequestsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> cancel(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).cancel(requestId);
        ref.invalidate(sentFriendRequestsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> removeFriend(String friendUserId) => _run(() async {
        await ref.read(friendsApiProvider).removeFriend(friendUserId);
        ref.invalidate(friendsProvider);
        ref.invalidate(friendStatusProvider(friendUserId));
      });
}
