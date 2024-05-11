import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp implements AuthRepository {
  final SupabaseClient _supabase;
  final MemberRepository _memberRepository;

  AuthRepositoryImp({
    required SupabaseClient supabase,
    required MemberRepository memberRepository,
  })  : _supabase = supabase,
        _memberRepository = memberRepository;

  @override
  Future<String> addUser({
    required String email,
    required String password,
    required Role role,
  }) async {
    final res = await _supabase.auth.admin.createUser(
      AdminUserAttributes(
        email: email,
        password: password,
        userMetadata: {'role': role.name},
      ),
    );
    return res.user!.id;
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user == null) throw 'Terjadi kesalahan';
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    if (res.user == null) throw 'Terjadi kesalahan';
    await _memberRepository.add(
      id: res.user!.id,
      name: name,
      email: email,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
