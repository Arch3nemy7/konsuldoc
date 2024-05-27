import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:konsuldoc/presentations/providers/notification_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp implements AuthRepository {
  final SupabaseClient _supabase;
  final SupabaseClient _supabaseAdmin;
  final MemberRepository _memberRepository;
  final NotificationService _notificationService;

  AuthRepositoryImp(
      {required SupabaseClient supabase,
      required SupabaseClient supabaseAdmin,
      required MemberRepository memberRepository,
      required NotificationService notificationService})
      : _supabase = supabase,
        _supabaseAdmin = supabaseAdmin,
        _memberRepository = memberRepository,
        _notificationService = notificationService;

  @override
  Future<String> addUser({
    required String email,
    required String password,
    required Role role,
  }) async {
    final res = await _supabaseAdmin.auth.admin.createUser(
      AdminUserAttributes(
        email: email,
        password: password,
        appMetadata: {'role': role.name},
        emailConfirm: true,
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
    _notificationService.updateToken(_notificationService.getToken());
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
    _notificationService.updateToken(_notificationService.getToken());
  }

  @override
  Future<void> signOut() async {
    _notificationService.updateToken(null);
    await _supabase.auth.signOut();
  }

  @override
  Future<void> deleteUser(String id) async {
    await _supabaseAdmin.auth.admin.deleteUser(id);
  }
}
