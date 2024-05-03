import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/domain/models/failure.dart';
import 'package:konsuldoc/domain/models/user.dart';
import 'package:konsuldoc/typedefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository({required SupabaseClient supabase}) : _supabase = supabase;

  FutureEither<UserModel> signIn({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: res.user!.id,
        name: name,
        role: Role.member,
      );

      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user == null) throw 'Gagal untuk masuk';
      final user = UserModel(
        id: res.user!.id,
        name: name,
        role: Role.member,
      );

      // await _supabase.from('user').insert(user)

      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid signOut() async {
    try {
      await _supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
