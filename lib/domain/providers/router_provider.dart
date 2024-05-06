import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/models/user.dart';
import 'package:konsuldoc/domain/providers/user_state_provider.dart';
import 'package:konsuldoc/router/admin_router.dart';
import 'package:konsuldoc/router/auth_router.dart';
import 'package:konsuldoc/router/doctor_router.dart';
import 'package:konsuldoc/router/member_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
RouterConfig<Object> router(RouterRef ref) {
  final userRole = ref.watch(userStateProvider.select((user) => user?.role));

  return switch (userRole) {
    Role.admin => AdminRouter().config(),
    Role.doctor => DoctorRouter().config(),
    Role.member => MemberRouter().config(),
    _ => AuthRouter().config(),
  };
}
