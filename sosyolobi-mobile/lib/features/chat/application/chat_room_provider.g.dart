// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRoomHash() => r'15dc2d8d08988c2ce74faf2b59e6abfe06c7c1a8';

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

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
///
/// Copied from [chatRoom].
@ProviderFor(chatRoom)
const chatRoomProvider = ChatRoomFamily();

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
///
/// Copied from [chatRoom].
class ChatRoomFamily extends Family<AsyncValue<ChatRoom>> {
  /// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
  ///
  /// Copied from [chatRoom].
  const ChatRoomFamily();

  /// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
  ///
  /// Copied from [chatRoom].
  ChatRoomProvider call(String activityId) {
    return ChatRoomProvider(activityId);
  }

  @override
  ChatRoomProvider getProviderOverride(covariant ChatRoomProvider provider) {
    return call(provider.activityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatRoomProvider';
}

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
///
/// Copied from [chatRoom].
class ChatRoomProvider extends AutoDisposeFutureProvider<ChatRoom> {
  /// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
  ///
  /// Copied from [chatRoom].
  ChatRoomProvider(String activityId)
    : this._internal(
        (ref) => chatRoom(ref as ChatRoomRef, activityId),
        from: chatRoomProvider,
        name: r'chatRoomProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatRoomHash,
        dependencies: ChatRoomFamily._dependencies,
        allTransitiveDependencies: ChatRoomFamily._allTransitiveDependencies,
        activityId: activityId,
      );

  ChatRoomProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activityId,
  }) : super.internal();

  final String activityId;

  @override
  Override overrideWith(
    FutureOr<ChatRoom> Function(ChatRoomRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatRoomProvider._internal(
        (ref) => create(ref as ChatRoomRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activityId: activityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatRoom> createElement() {
    return _ChatRoomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomProvider && other.activityId == activityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatRoomRef on AutoDisposeFutureProviderRef<ChatRoom> {
  /// The parameter `activityId` of this provider.
  String get activityId;
}

class _ChatRoomProviderElement
    extends AutoDisposeFutureProviderElement<ChatRoom>
    with ChatRoomRef {
  _ChatRoomProviderElement(super.provider);

  @override
  String get activityId => (origin as ChatRoomProvider).activityId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
