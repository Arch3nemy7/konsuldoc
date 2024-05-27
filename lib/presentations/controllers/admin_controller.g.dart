// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminControllerHash() => r'ce558782483b166d950a77b41d4adc519089374b';

/// See also [adminController].
@ProviderFor(adminController)
final adminControllerProvider = AutoDisposeProvider<AdminController>.internal(
  adminController,
  name: r'adminControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AdminControllerRef = AutoDisposeProviderRef<AdminController>;
String _$fetchAllAdminHash() => r'35aa3f243c6b3b0c3409d7b610f21323c6096677';

/// See also [fetchAllAdmin].
@ProviderFor(fetchAllAdmin)
final fetchAllAdminProvider = AutoDisposeStreamProvider<List<Admin>>.internal(
  fetchAllAdmin,
  name: r'fetchAllAdminProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllAdminRef = AutoDisposeStreamProviderRef<List<Admin>>;
String _$fetchAdminByIdHash() => r'a2b947ad96a6b5107e8fa81194d951e27c3cd5c6';

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

/// See also [fetchAdminById].
@ProviderFor(fetchAdminById)
const fetchAdminByIdProvider = FetchAdminByIdFamily();

/// See also [fetchAdminById].
class FetchAdminByIdFamily extends Family<AsyncValue<Admin>> {
  /// See also [fetchAdminById].
  const FetchAdminByIdFamily();

  /// See also [fetchAdminById].
  FetchAdminByIdProvider call(
    String id,
  ) {
    return FetchAdminByIdProvider(
      id,
    );
  }

  @override
  FetchAdminByIdProvider getProviderOverride(
    covariant FetchAdminByIdProvider provider,
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
  String? get name => r'fetchAdminByIdProvider';
}

/// See also [fetchAdminById].
class FetchAdminByIdProvider extends AutoDisposeStreamProvider<Admin> {
  /// See also [fetchAdminById].
  FetchAdminByIdProvider(
    String id,
  ) : this._internal(
          (ref) => fetchAdminById(
            ref as FetchAdminByIdRef,
            id,
          ),
          from: fetchAdminByIdProvider,
          name: r'fetchAdminByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAdminByIdHash,
          dependencies: FetchAdminByIdFamily._dependencies,
          allTransitiveDependencies:
              FetchAdminByIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchAdminByIdProvider._internal(
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
    Stream<Admin> Function(FetchAdminByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAdminByIdProvider._internal(
        (ref) => create(ref as FetchAdminByIdRef),
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
  AutoDisposeStreamProviderElement<Admin> createElement() {
    return _FetchAdminByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAdminByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAdminByIdRef on AutoDisposeStreamProviderRef<Admin> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchAdminByIdProviderElement
    extends AutoDisposeStreamProviderElement<Admin> with FetchAdminByIdRef {
  _FetchAdminByIdProviderElement(super.provider);

  @override
  String get id => (origin as FetchAdminByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
