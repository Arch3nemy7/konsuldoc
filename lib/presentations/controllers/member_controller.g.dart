// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memberControllerHash() => r'2dcd5b9afba66908f51e46b09b9ea6e439a67d01';

/// See also [memberController].
@ProviderFor(memberController)
final memberControllerProvider = AutoDisposeProvider<MemberController>.internal(
  memberController,
  name: r'memberControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memberControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MemberControllerRef = AutoDisposeProviderRef<MemberController>;
String _$fetchMemberByIdHash() => r'0fcc970ad63f0c878958f4f71d9b70756750fa08';

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

/// See also [fetchMemberById].
@ProviderFor(fetchMemberById)
const fetchMemberByIdProvider = FetchMemberByIdFamily();

/// See also [fetchMemberById].
class FetchMemberByIdFamily extends Family<AsyncValue<Member>> {
  /// See also [fetchMemberById].
  const FetchMemberByIdFamily();

  /// See also [fetchMemberById].
  FetchMemberByIdProvider call(
    String id,
  ) {
    return FetchMemberByIdProvider(
      id,
    );
  }

  @override
  FetchMemberByIdProvider getProviderOverride(
    covariant FetchMemberByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'fetchMemberByIdProvider';
}

/// See also [fetchMemberById].
class FetchMemberByIdProvider extends AutoDisposeStreamProvider<Member> {
  /// See also [fetchMemberById].
  FetchMemberByIdProvider(
    String id,
  ) : this._internal(
          (ref) => fetchMemberById(
            ref as FetchMemberByIdRef,
            id,
          ),
          from: fetchMemberByIdProvider,
          name: r'fetchMemberByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMemberByIdHash,
          dependencies: FetchMemberByIdFamily._dependencies,
          allTransitiveDependencies:
              FetchMemberByIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchMemberByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Member> Function(FetchMemberByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchMemberByIdProvider._internal(
        (ref) => create(ref as FetchMemberByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Member> createElement() {
    return _FetchMemberByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchMemberByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchMemberByIdRef on AutoDisposeStreamProviderRef<Member> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchMemberByIdProviderElement
    extends AutoDisposeStreamProviderElement<Member> with FetchMemberByIdRef {
  _FetchMemberByIdProviderElement(super.provider);

  @override
  String get id => (origin as FetchMemberByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
