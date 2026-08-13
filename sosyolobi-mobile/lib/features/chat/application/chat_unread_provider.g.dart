// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_unread_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalUnreadChatRoomsHash() =>
    r'506b4d969806fa42cbb2cb673f66bb6b39a14b95';

/// Total unread chat rooms — feeds into the combined notification badge
/// (`AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`).
///
/// Copied from [totalUnreadChatRooms].
@ProviderFor(totalUnreadChatRooms)
final totalUnreadChatRoomsProvider = AutoDisposeProvider<int>.internal(
  totalUnreadChatRooms,
  name: r'totalUnreadChatRoomsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalUnreadChatRoomsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalUnreadChatRoomsRef = AutoDisposeProviderRef<int>;
String _$chatUnreadHash() => r'a61c53d26d6268e6b461bfe6f6d02ef590c99ea8';

/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide).
///
/// Copied from [ChatUnread].
@ProviderFor(ChatUnread)
final chatUnreadProvider =
    AsyncNotifierProvider<ChatUnread, List<ChatUnreadSummary>>.internal(
      ChatUnread.new,
      name: r'chatUnreadProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatUnreadHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ChatUnread = AsyncNotifier<List<ChatUnreadSummary>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
