// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentControllerHash() =>
    r'299ad8fc124185d4fd7321865e9ab7a65c756993';

/// See also [appointmentController].
@ProviderFor(appointmentController)
final appointmentControllerProvider =
    AutoDisposeProvider<AppointmentController>.internal(
  appointmentController,
  name: r'appointmentControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appointmentControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppointmentControllerRef
    = AutoDisposeProviderRef<AppointmentController>;
String _$fetchAppointmentByIdHash() =>
    r'c0885530533ad1cc4271a2d703df0518f1c7efa1';

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

/// See also [fetchAppointmentById].
@ProviderFor(fetchAppointmentById)
const fetchAppointmentByIdProvider = FetchAppointmentByIdFamily();

/// See also [fetchAppointmentById].
class FetchAppointmentByIdFamily extends Family<AsyncValue<Appointment>> {
  /// See also [fetchAppointmentById].
  const FetchAppointmentByIdFamily();

  /// See also [fetchAppointmentById].
  FetchAppointmentByIdProvider call(
    String id,
  ) {
    return FetchAppointmentByIdProvider(
      id,
    );
  }

  @override
  FetchAppointmentByIdProvider getProviderOverride(
    covariant FetchAppointmentByIdProvider provider,
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
  String? get name => r'fetchAppointmentByIdProvider';
}

/// See also [fetchAppointmentById].
class FetchAppointmentByIdProvider
    extends AutoDisposeStreamProvider<Appointment> {
  /// See also [fetchAppointmentById].
  FetchAppointmentByIdProvider(
    String id,
  ) : this._internal(
          (ref) => fetchAppointmentById(
            ref as FetchAppointmentByIdRef,
            id,
          ),
          from: fetchAppointmentByIdProvider,
          name: r'fetchAppointmentByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAppointmentByIdHash,
          dependencies: FetchAppointmentByIdFamily._dependencies,
          allTransitiveDependencies:
              FetchAppointmentByIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchAppointmentByIdProvider._internal(
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
    Stream<Appointment> Function(FetchAppointmentByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAppointmentByIdProvider._internal(
        (ref) => create(ref as FetchAppointmentByIdRef),
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
  AutoDisposeStreamProviderElement<Appointment> createElement() {
    return _FetchAppointmentByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAppointmentByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAppointmentByIdRef on AutoDisposeStreamProviderRef<Appointment> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchAppointmentByIdProviderElement
    extends AutoDisposeStreamProviderElement<Appointment>
    with FetchAppointmentByIdRef {
  _FetchAppointmentByIdProviderElement(super.provider);

  @override
  String get id => (origin as FetchAppointmentByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
