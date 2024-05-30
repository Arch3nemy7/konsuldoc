import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/admin_router.dart';
import 'package:konsuldoc/core/router/auth_router.dart';
import 'package:konsuldoc/core/router/doctor_router.dart';
import 'package:konsuldoc/core/router/member_router.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
Raw<RootStackRouter> router(RouterRef ref) {
  final router = switch (ref.watch(userRoleProvider)) {
    Role.admin => AdminRouter(),
    Role.doctor => DoctorRouter(),
    Role.member => MemberRouter(),
    _ => AuthRouter(),
  };

  return router;
}
