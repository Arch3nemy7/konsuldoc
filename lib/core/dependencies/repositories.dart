import 'package:konsuldoc/core/dependencies/supabase.dart';
import 'package:konsuldoc/data/repositories/admin_repository_impl.dart';
import 'package:konsuldoc/data/repositories/appointment_repository_impl.dart';
import 'package:konsuldoc/data/repositories/auth_repository_impl.dart';
import 'package:konsuldoc/data/repositories/doctor_repository_impl.dart';
import 'package:konsuldoc/data/repositories/member_repository_impl.dart';
import 'package:konsuldoc/data/repositories/storage_repository_impl.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:konsuldoc/domain/repositories/appointment_repository.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/domain/repositories/doctor_repository.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:konsuldoc/domain/repositories/storage_repository.dart';
import 'package:konsuldoc/presentations/providers/notification_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories.g.dart';

// Repositories
@riverpod
StorageRepository storageRepository(StorageRepositoryRef ref) {
  return StorageRepositoryImpl(supabase: ref.watch(supabaseProvider).client);
}

@riverpod
MemberRepository memberRepository(MemberRepositoryRef ref) {
  return MemberRepositoryImpl(
    supabase: ref.watch(supabaseProvider).client,
    storageRepository: ref.watch(storageRepositoryProvider),
  );
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImp(
    supabase: ref.watch(supabaseProvider).client,
    supabaseAdmin: ref.watch(supabaseAdminProvider),
    memberRepository: ref.watch(memberRepositoryProvider),
    notificationService: ref.watch(notificationServiceProvider.notifier),
  );
}

@riverpod
DoctorRepository doctorRepository(DoctorRepositoryRef ref) {
  return DoctorRepositoryImpl(
    supabase: ref.watch(supabaseProvider).client,
    authRepository: ref.watch(authRepositoryProvider),
    storageRepository: ref.watch(storageRepositoryProvider),
  );
}

@riverpod
AdminRepository adminRepository(AdminRepositoryRef ref) {
  return AdminRepositoryImpl(
    supabase: ref.watch(supabaseProvider).client,
    authRepository: ref.watch(authRepositoryProvider),
    storageRepository: ref.watch(storageRepositoryProvider),
  );
}

@riverpod
AppointmentRepository appointmentRepository(AppointmentRepositoryRef ref) {
  return AppointmentRepositoryImpl(
      supabase: ref.watch(supabaseProvider).client);
}
