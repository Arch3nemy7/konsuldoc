import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_provider.g.dart';

@riverpod
Stream<User?> userState(UserStateRef ref) {
  final id = ref.watch(authStateProvider)?.id;
  final role = ref.watch(userRoleProvider);

  return switch (role) {
    null => const Stream.empty(),
    Role.member => ref.watch(memberRepositoryProvider).fetchById(id!),
    Role.admin => ref.watch(adminRepositoryProvider).fetchById(id!),
    Role.doctor => ref.watch(doctorRepositoryProvider).fetchById(id!),
  };
}
