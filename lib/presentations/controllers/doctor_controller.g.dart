// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$doctorControllerHash() => r'7a3b56372e8792693128135de1f86e86f396625b';

/// See also [doctorController].
@ProviderFor(doctorController)
final doctorControllerProvider = AutoDisposeProvider<DoctorController>.internal(
  doctorController,
  name: r'doctorControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$doctorControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DoctorControllerRef = AutoDisposeProviderRef<DoctorController>;
String _$fetchAllDoctorHash() => r'b7aedaf83f52e080495ecba06703b6296466d26e';

/// See also [fetchAllDoctor].
@ProviderFor(fetchAllDoctor)
final fetchAllDoctorProvider = AutoDisposeStreamProvider<List<Doctor>>.internal(
  fetchAllDoctor,
  name: r'fetchAllDoctorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllDoctorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllDoctorRef = AutoDisposeStreamProviderRef<List<Doctor>>;
String _$fetchDoctorByIdHash() => r'd32a3592b4e1f11f1d3e0a48deb33ce1da08a33e';

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

/// See also [fetchDoctorById].
@ProviderFor(fetchDoctorById)
const fetchDoctorByIdProvider = FetchDoctorByIdFamily();

/// See also [fetchDoctorById].
class FetchDoctorByIdFamily extends Family<AsyncValue<Doctor>> {
  /// See also [fetchDoctorById].
  const FetchDoctorByIdFamily();

  /// See also [fetchDoctorById].
  FetchDoctorByIdProvider call(
    String id,
  ) {
    return FetchDoctorByIdProvider(
      id,
    );
  }

  @override
  FetchDoctorByIdProvider getProviderOverride(
    covariant FetchDoctorByIdProvider provider,
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
  String? get name => r'fetchDoctorByIdProvider';
}

/// See also [fetchDoctorById].
class FetchDoctorByIdProvider extends AutoDisposeStreamProvider<Doctor> {
  /// See also [fetchDoctorById].
  FetchDoctorByIdProvider(
    String id,
  ) : this._internal(
          (ref) => fetchDoctorById(
            ref as FetchDoctorByIdRef,
            id,
          ),
          from: fetchDoctorByIdProvider,
          name: r'fetchDoctorByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchDoctorByIdHash,
          dependencies: FetchDoctorByIdFamily._dependencies,
          allTransitiveDependencies:
              FetchDoctorByIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchDoctorByIdProvider._internal(
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
    Stream<Doctor> Function(FetchDoctorByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchDoctorByIdProvider._internal(
        (ref) => create(ref as FetchDoctorByIdRef),
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
  AutoDisposeStreamProviderElement<Doctor> createElement() {
    return _FetchDoctorByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchDoctorByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchDoctorByIdRef on AutoDisposeStreamProviderRef<Doctor> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchDoctorByIdProviderElement
    extends AutoDisposeStreamProviderElement<Doctor> with FetchDoctorByIdRef {
  _FetchDoctorByIdProviderElement(super.provider);

  @override
  String get id => (origin as FetchDoctorByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
