import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

abstract interface class AuthRepository {
  Future<void> addUser({
    required String email,
    required String password,
    required Role role,
  });
  Future<User> signIn({
    required String email,
    required String password,
  });
  Future<Member> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
}
