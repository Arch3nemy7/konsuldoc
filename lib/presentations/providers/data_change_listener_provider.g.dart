// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_change_listener_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changeChannelHash() => r'4e668d3f710cb72f9f5a0f598616b4c63747a1fa';

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

/// See also [changeChannel].
@ProviderFor(changeChannel)
const changeChannelProvider = ChangeChannelFamily();

/// See also [changeChannel].
class ChangeChannelFamily extends Family<ChangeChannel> {
  /// See also [changeChannel].
  const ChangeChannelFamily();

  /// See also [changeChannel].
  ChangeChannelProvider call(
    ChangeChannel<dynamic> channel,
  ) {
    return ChangeChannelProvider(
      channel,
    );
  }

  @override
  ChangeChannelProvider getProviderOverride(
    covariant ChangeChannelProvider provider,
  ) {
    return call(
      provider.channel,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'changeChannelProvider';
}

/// See also [changeChannel].
class ChangeChannelProvider extends AutoDisposeProvider<ChangeChannel> {
  /// See also [changeChannel].
  ChangeChannelProvider(
    ChangeChannel<dynamic> channel,
  ) : this._internal(
          (ref) => changeChannel(
            ref as ChangeChannelRef,
            channel,
          ),
          from: changeChannelProvider,
          name: r'changeChannelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$changeChannelHash,
          dependencies: ChangeChannelFamily._dependencies,
          allTransitiveDependencies:
              ChangeChannelFamily._allTransitiveDependencies,
          channel: channel,
        );

  ChangeChannelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channel,
  }) : super.internal();

  final ChangeChannel<dynamic> channel;

  @override
  Override overrideWith(
    ChangeChannel Function(ChangeChannelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChangeChannelProvider._internal(
        (ref) => create(ref as ChangeChannelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channel: channel,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ChangeChannel> createElement() {
    return _ChangeChannelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChangeChannelProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChangeChannelRef on AutoDisposeProviderRef<ChangeChannel> {
  /// The parameter `channel` of this provider.
  ChangeChannel<dynamic> get channel;
}

class _ChangeChannelProviderElement
    extends AutoDisposeProviderElement<ChangeChannel> with ChangeChannelRef {
  _ChangeChannelProviderElement(super.provider);

  @override
  ChangeChannel<dynamic> get channel =>
      (origin as ChangeChannelProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
