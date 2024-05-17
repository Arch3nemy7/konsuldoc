import 'package:konsuldoc/domain/enums/role.dart';

abstract interface class AuthRepository {
  Future<String> addUser({
    required String email,
    required String password,
    required Role role,
  });
  Future<void> signIn({
    required String email,
    required String password,
  });
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> deleteUser(String id);
}
