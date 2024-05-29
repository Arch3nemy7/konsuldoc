import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_role_provider.g.dart';

@riverpod
Role? userRole(UserRoleRef ref) {
  final user = ref.watch(authStateProvider);
  return user == null
      ? null
      : Role.values.byName(user.appMetadata['role'] ?? 'member');
}
