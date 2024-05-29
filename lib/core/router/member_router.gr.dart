// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:konsuldoc/domain/entities/member.dart' as _i12;
import 'package:konsuldoc/presentations/pages/common/appointment_detail_page.dart'
    as _i1;
import 'package:konsuldoc/presentations/pages/common/doctor_detail_page.dart'
    as _i4;
import 'package:konsuldoc/presentations/pages/common/member_detail_page.dart'
    as _i5;
import 'package:konsuldoc/presentations/pages/member/appointment_list_page.dart'
    as _i2;
import 'package:konsuldoc/presentations/pages/member/create_appointment_page.dart'
    as _i3;
import 'package:konsuldoc/presentations/pages/member/member_form_page.dart'
    as _i6;
import 'package:konsuldoc/presentations/pages/member/member_home_page.dart'
    as _i7;
import 'package:konsuldoc/presentations/pages/member/member_profile_page.dart'
    as _i8;
import 'package:konsuldoc/presentations/pages/member/member_root_page.dart'
    as _i9;

abstract class $MemberRouter extends _i10.RootStackRouter {
  $MemberRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AppointmentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AppointmentDetailRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AppointmentDetailPage(
          key: args.key,
          id: args.id,
          canConfirm: args.canConfirm,
        ),
      );
    },
    AppointmentListRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AppointmentListPage(),
      );
    },
    CreateAppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<CreateAppointmentRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CreateAppointmentPage(
          key: args.key,
          idDoctor: args.idDoctor,
        ),
      );
    },
    DoctorDetailRoute.name: (routeData) {
      final args = routeData.argsAs<DoctorDetailRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DoctorDetailPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MemberDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MemberDetailRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.MemberDetailPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MemberFormRoute.name: (routeData) {
      final args = routeData.argsAs<MemberFormRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.MemberFormPage(
          key: args.key,
          member: args.member,
        ),
      );
    },
    MemberHomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MemberHomePage(),
      );
    },
    MemberProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MemberProfilePage(),
      );
    },
    MemberRootRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MemberRootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppointmentDetailPage]
class AppointmentDetailRoute
    extends _i10.PageRouteInfo<AppointmentDetailRouteArgs> {
  AppointmentDetailRoute({
    _i11.Key? key,
    required String id,
    bool canConfirm = false,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AppointmentDetailRoute.name,
          args: AppointmentDetailRouteArgs(
            key: key,
            id: id,
            canConfirm: canConfirm,
          ),
          initialChildren: children,
        );

  static const String name = 'AppointmentDetailRoute';

  static const _i10.PageInfo<AppointmentDetailRouteArgs> page =
      _i10.PageInfo<AppointmentDetailRouteArgs>(name);
}

class AppointmentDetailRouteArgs {
  const AppointmentDetailRouteArgs({
    this.key,
    required this.id,
    this.canConfirm = false,
  });

  final _i11.Key? key;

  final String id;

  final bool canConfirm;

  @override
  String toString() {
    return 'AppointmentDetailRouteArgs{key: $key, id: $id, canConfirm: $canConfirm}';
  }
}

/// generated route for
/// [_i2.AppointmentListPage]
class AppointmentListRoute extends _i10.PageRouteInfo<void> {
  const AppointmentListRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AppointmentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentListRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreateAppointmentPage]
class CreateAppointmentRoute
    extends _i10.PageRouteInfo<CreateAppointmentRouteArgs> {
  CreateAppointmentRoute({
    _i11.Key? key,
    required String idDoctor,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CreateAppointmentRoute.name,
          args: CreateAppointmentRouteArgs(
            key: key,
            idDoctor: idDoctor,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateAppointmentRoute';

  static const _i10.PageInfo<CreateAppointmentRouteArgs> page =
      _i10.PageInfo<CreateAppointmentRouteArgs>(name);
}

class CreateAppointmentRouteArgs {
  const CreateAppointmentRouteArgs({
    this.key,
    required this.idDoctor,
  });

  final _i11.Key? key;

  final String idDoctor;

  @override
  String toString() {
    return 'CreateAppointmentRouteArgs{key: $key, idDoctor: $idDoctor}';
  }
}

/// generated route for
/// [_i4.DoctorDetailPage]
class DoctorDetailRoute extends _i10.PageRouteInfo<DoctorDetailRouteArgs> {
  DoctorDetailRoute({
    _i11.Key? key,
    required String id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          DoctorDetailRoute.name,
          args: DoctorDetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DoctorDetailRoute';

  static const _i10.PageInfo<DoctorDetailRouteArgs> page =
      _i10.PageInfo<DoctorDetailRouteArgs>(name);
}

class DoctorDetailRouteArgs {
  const DoctorDetailRouteArgs({
    this.key,
    required this.id,
  });

  final _i11.Key? key;

  final String id;

  @override
  String toString() {
    return 'DoctorDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i5.MemberDetailPage]
class MemberDetailRoute extends _i10.PageRouteInfo<MemberDetailRouteArgs> {
  MemberDetailRoute({
    _i11.Key? key,
    required String id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          MemberDetailRoute.name,
          args: MemberDetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberDetailRoute';

  static const _i10.PageInfo<MemberDetailRouteArgs> page =
      _i10.PageInfo<MemberDetailRouteArgs>(name);
}

class MemberDetailRouteArgs {
  const MemberDetailRouteArgs({
    this.key,
    required this.id,
  });

  final _i11.Key? key;

  final String id;

  @override
  String toString() {
    return 'MemberDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i6.MemberFormPage]
class MemberFormRoute extends _i10.PageRouteInfo<MemberFormRouteArgs> {
  MemberFormRoute({
    _i11.Key? key,
    required _i12.Member member,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          MemberFormRoute.name,
          args: MemberFormRouteArgs(
            key: key,
            member: member,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberFormRoute';

  static const _i10.PageInfo<MemberFormRouteArgs> page =
      _i10.PageInfo<MemberFormRouteArgs>(name);
}

class MemberFormRouteArgs {
  const MemberFormRouteArgs({
    this.key,
    required this.member,
  });

  final _i11.Key? key;

  final _i12.Member member;

  @override
  String toString() {
    return 'MemberFormRouteArgs{key: $key, member: $member}';
  }
}

/// generated route for
/// [_i7.MemberHomePage]
class MemberHomeRoute extends _i10.PageRouteInfo<void> {
  const MemberHomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MemberHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberHomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MemberProfilePage]
class MemberProfileRoute extends _i10.PageRouteInfo<void> {
  const MemberProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MemberProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MemberRootPage]
class MemberRootRoute extends _i10.PageRouteInfo<void> {
  const MemberRootRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MemberRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberRootRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
