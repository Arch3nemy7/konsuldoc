import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/admin_model.dart';
import 'package:konsuldoc/data/models/doctor_model.dart';
import 'package:konsuldoc/data/models/member_model.dart';
import 'package:konsuldoc/data/models/user_model.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/presentations/providers/supabase_admin_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepositoryImp authRepositoryImpl(AuthRepositoryImplRef ref) {
  return AuthRepositoryImp(supabase: ref.watch(supabaseAdminProvider));
}

class AuthRepositoryImp implements AuthRepository {
  final SupabaseClient _supabase;

  AuthRepositoryImp({required SupabaseClient supabase}) : _supabase = supabase;

  @override
  Future<void> addUser({
    required String email,
    required String password,
    required Role role,
  }) async {
    await _supabase.auth.admin.createUser(
      AdminUserAttributes(
        email: email,
        password: password,
        userMetadata: {'role': role.name},
      ),
    );
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user == null) throw 'Terjadi kesalahan';

    final role = Role.values.byName(res.user!.userMetadata!['role']);
    final data =
        (await _supabase.from(role.table).select().eq('id', res.user!.id))
            .first;

    return switch (role) {
      Role.member => MemberModel.fromMap(data),
      Role.admin => AdminModel.fromMap(data),
      Role.doctor => DoctorModel.fromMap(data),
    };
  }

  @override
  Future<MemberModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    if (res.user == null) throw 'Terjadi kesalahan';

    final data = await _supabase
        .from(TableConstants.members)
        .select()
        .eq('id', res.user!.id);

    // TODO: save member data to database

    return MemberModel.fromMap(data.first);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
