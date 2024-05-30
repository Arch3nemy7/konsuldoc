// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:konsuldoc/presentations/pages/common/appointment_detail_page.dart'
    as _i1;
import 'package:konsuldoc/presentations/pages/common/doctor_detail_page.dart'
    as _i3;
import 'package:konsuldoc/presentations/pages/common/member_detail_page.dart'
    as _i6;
import 'package:konsuldoc/presentations/pages/doctor/doctor_appointment_list_page.dart'
    as _i2;
import 'package:konsuldoc/presentations/pages/doctor/doctor_home_page.dart'
    as _i4;
import 'package:konsuldoc/presentations/pages/doctor/doctor_root_page.dart'
    as _i5;

abstract class $DoctorRouter extends _i7.RootStackRouter {
  $DoctorRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AppointmentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AppointmentDetailRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AppointmentDetailPage(
          key: args.key,
          id: args.id,
          canConfirm: args.canConfirm,
        ),
      );
    },
    DoctorAppointmentListRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DoctorAppointmentListPage(),
      );
    },
    DoctorDetailRoute.name: (routeData) {
      final args = routeData.argsAs<DoctorDetailRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DoctorDetailPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    DoctorHomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DoctorHomePage(),
      );
    },
    DoctorRootRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DoctorRootPage(),
      );
    },
    MemberDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MemberDetailRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.MemberDetailPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AppointmentDetailPage]
class AppointmentDetailRoute
    extends _i7.PageRouteInfo<AppointmentDetailRouteArgs> {
  AppointmentDetailRoute({
    _i8.Key? key,
    required String id,
    bool canConfirm = false,
    List<_i7.PageRouteInfo>? children,
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

  static const _i7.PageInfo<AppointmentDetailRouteArgs> page =
      _i7.PageInfo<AppointmentDetailRouteArgs>(name);
}

class AppointmentDetailRouteArgs {
  const AppointmentDetailRouteArgs({
    this.key,
    required this.id,
    this.canConfirm = false,
  });

  final _i8.Key? key;

  final String id;

  final bool canConfirm;

  @override
  String toString() {
    return 'AppointmentDetailRouteArgs{key: $key, id: $id, canConfirm: $canConfirm}';
  }
}

/// generated route for
/// [_i2.DoctorAppointmentListPage]
class DoctorAppointmentListRoute extends _i7.PageRouteInfo<void> {
  const DoctorAppointmentListRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DoctorAppointmentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorAppointmentListRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DoctorDetailPage]
class DoctorDetailRoute extends _i7.PageRouteInfo<DoctorDetailRouteArgs> {
  DoctorDetailRoute({
    _i8.Key? key,
    required String id,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DoctorDetailRoute.name,
          args: DoctorDetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DoctorDetailRoute';

  static const _i7.PageInfo<DoctorDetailRouteArgs> page =
      _i7.PageInfo<DoctorDetailRouteArgs>(name);
}

class DoctorDetailRouteArgs {
  const DoctorDetailRouteArgs({
    this.key,
    required this.id,
  });

  final _i8.Key? key;

  final String id;

  @override
  String toString() {
    return 'DoctorDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.DoctorHomePage]
class DoctorHomeRoute extends _i7.PageRouteInfo<void> {
  const DoctorHomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DoctorHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorHomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DoctorRootPage]
class DoctorRootRoute extends _i7.PageRouteInfo<void> {
  const DoctorRootRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DoctorRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorRootRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MemberDetailPage]
class MemberDetailRoute extends _i7.PageRouteInfo<MemberDetailRouteArgs> {
  MemberDetailRoute({
    _i8.Key? key,
    required String id,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          MemberDetailRoute.name,
          args: MemberDetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberDetailRoute';

  static const _i7.PageInfo<MemberDetailRouteArgs> page =
      _i7.PageInfo<MemberDetailRouteArgs>(name);
}

class MemberDetailRouteArgs {
  const MemberDetailRouteArgs({
    this.key,
    required this.id,
  });

  final _i8.Key? key;

  final String id;

  @override
  String toString() {
    return 'MemberDetailRouteArgs{key: $key, id: $id}';
  }
}
