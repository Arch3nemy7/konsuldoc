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
String _$fetchBookedSessionsHash() =>
    r'e20c12315c06f8d95b093d32dbe2f5579e96eb20';

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

/// See also [fetchBookedSessions].
@ProviderFor(fetchBookedSessions)
const fetchBookedSessionsProvider = FetchBookedSessionsFamily();

/// See also [fetchBookedSessions].
class FetchBookedSessionsFamily
    extends Family<AsyncValue<List<AppointmentSession>>> {
  /// See also [fetchBookedSessions].
  const FetchBookedSessionsFamily();

  /// See also [fetchBookedSessions].
  FetchBookedSessionsProvider call(
    String idDoctor,
  ) {
    return FetchBookedSessionsProvider(
      idDoctor,
    );
  }

  @override
  FetchBookedSessionsProvider getProviderOverride(
    covariant FetchBookedSessionsProvider provider,
  ) {
    return call(
      provider.idDoctor,
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
  String? get name => r'fetchBookedSessionsProvider';
}

/// See also [fetchBookedSessions].
class FetchBookedSessionsProvider
    extends AutoDisposeFutureProvider<List<AppointmentSession>> {
  /// See also [fetchBookedSessions].
  FetchBookedSessionsProvider(
    String idDoctor,
  ) : this._internal(
          (ref) => fetchBookedSessions(
            ref as FetchBookedSessionsRef,
            idDoctor,
          ),
          from: fetchBookedSessionsProvider,
          name: r'fetchBookedSessionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchBookedSessionsHash,
          dependencies: FetchBookedSessionsFamily._dependencies,
          allTransitiveDependencies:
              FetchBookedSessionsFamily._allTransitiveDependencies,
          idDoctor: idDoctor,
        );

  FetchBookedSessionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.idDoctor,
  }) : super.internal();

  final String idDoctor;

  @override
  Override overrideWith(
    FutureOr<List<AppointmentSession>> Function(FetchBookedSessionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchBookedSessionsProvider._internal(
        (ref) => create(ref as FetchBookedSessionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        idDoctor: idDoctor,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AppointmentSession>> createElement() {
    return _FetchBookedSessionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchBookedSessionsProvider && other.idDoctor == idDoctor;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, idDoctor.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchBookedSessionsRef
    on AutoDisposeFutureProviderRef<List<AppointmentSession>> {
  /// The parameter `idDoctor` of this provider.
  String get idDoctor;
}

class _FetchBookedSessionsProviderElement
    extends AutoDisposeFutureProviderElement<List<AppointmentSession>>
    with FetchBookedSessionsRef {
  _FetchBookedSessionsProviderElement(super.provider);

  @override
  String get idDoctor => (origin as FetchBookedSessionsProvider).idDoctor;
}

String _$fetchAppointmentByIdHash() =>
    r'c0885530533ad1cc4271a2d703df0518f1c7efa1';

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
