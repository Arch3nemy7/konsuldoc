import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
import 'package:konsuldoc/core/router/admin_router.dart';
import 'package:konsuldoc/core/router/member_router.dart';
import 'package:konsuldoc/core/router/auth_router.dart';
import 'package:konsuldoc/core/router/doctor_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
RouterConfig<Object> router(RouterRef ref) {
  final userRole = ref.watch(userStateProvider.select((user) => user?.role));
  final router = switch (userRole) {
    Role.admin => AdminRouter(),
    Role.doctor => DoctorRouter(),
    Role.member => MemberRouter(),
    _ => AuthRouter(),
  };

  return router.config(
    navigatorObservers: () => [BotToastNavigatorObserver()],
  );
}
