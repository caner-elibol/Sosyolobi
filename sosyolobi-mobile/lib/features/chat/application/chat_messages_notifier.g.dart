// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessagesNotifierHash() =>
    r'11c07ef89952ab2e4aa82ba3b8fd5d6c372e0bf5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatMessagesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ChatRoomState> {
  late final String roomId;

  FutureOr<ChatRoomState> build(String roomId);
}

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.
///
/// Copied from [ChatMessagesNotifier].
@ProviderFor(ChatMessagesNotifier)
const chatMessagesNotifierProvider = ChatMessagesNotifierFamily();

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.
///
/// Copied from [ChatMessagesNotifier].
class ChatMessagesNotifierFamily extends Family<AsyncValue<ChatRoomState>> {
  /// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
  /// the panel (this provider) is created, joins the room, listens for
  /// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
  /// exactly web's per-mount connection lifecycle, not an app-wide singleton.
  ///
  /// Copied from [ChatMessagesNotifier].
  const ChatMessagesNotifierFamily();

  /// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
  /// the panel (this provider) is created, joins the room, listens for
  /// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
  /// exactly web's per-mount connection lifecycle, not an app-wide singleton.
  ///
  /// Copied from [ChatMessagesNotifier].
  ChatMessagesNotifierProvider call(String roomId) {
    return ChatMessagesNotifierProvider(roomId);
  }

  @override
  ChatMessagesNotifierProvider getProviderOverride(
    covariant ChatMessagesNotifierProvider provider,
  ) {
    return call(provider.roomId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatMessagesNotifierProvider';
}

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.
///
/// Copied from [ChatMessagesNotifier].
class ChatMessagesNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ChatMessagesNotifier,
          ChatRoomState
        > {
  /// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
  /// the panel (this provider) is created, joins the room, listens for
  /// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
  /// exactly web's per-mount connection lifecycle, not an app-wide singleton.
  ///
  /// Copied from [ChatMessagesNotifier].
  ChatMessagesNotifierProvider(String roomId)
    : this._internal(
        () => ChatMessagesNotifier()..roomId = roomId,
        from: chatMessagesNotifierProvider,
        name: r'chatMessagesNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatMessagesNotifierHash,
        dependencies: ChatMessagesNotifierFamily._dependencies,
        allTransitiveDependencies:
            ChatMessagesNotifierFamily._allTransitiveDependencies,
        roomId: roomId,
      );

  ChatMessagesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  FutureOr<ChatRoomState> runNotifierBuild(
    covariant ChatMessagesNotifier notifier,
  ) {
    return notifier.build(roomId);
  }

  @override
  Override overrideWith(ChatMessagesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesNotifierProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatMessagesNotifier, ChatRoomState>
  createElement() {
    return _ChatMessagesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatMessagesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ChatRoomState> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _ChatMessagesNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ChatMessagesNotifier,
          ChatRoomState
        >
    with ChatMessagesNotifierRef {
  _ChatMessagesNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as ChatMessagesNotifierProvider).roomId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
