// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:konsuldoc/presentations/pages/admin/admin_form_page.dart'
    as _i1;
import 'package:konsuldoc/presentations/pages/admin/admin_home_page.dart'
    as _i2;
import 'package:konsuldoc/presentations/pages/admin/admin_list_page.dart'
    as _i3;
import 'package:konsuldoc/presentations/pages/admin/admin_root_page.dart'
    as _i4;
import 'package:konsuldoc/presentations/pages/admin/doctor_form_page.dart'
    as _i8;
import 'package:konsuldoc/presentations/pages/admin/doctor_list_page.dart'
    as _i9;
import 'package:konsuldoc/presentations/pages/common/appointment_detail_page.dart'
    as _i5;
import 'package:konsuldoc/presentations/pages/common/appointment_list_page.dart'
    as _i6;
import 'package:konsuldoc/presentations/pages/common/doctor_detail_page.dart'
    as _i7;
import 'package:konsuldoc/presentations/pages/common/member_detail_page.dart'
    as _i10;

abstract class $AdminRouter extends _i11.RootStackRouter {
  $AdminRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AdminFormRoute.name: (routeData) {
      final args = routeData.argsAs<AdminFormRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AdminFormPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    AdminHomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminHomePage(),
      );
    },
    AdminListRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminListPage(),
      );
    },
    AdminRootRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AdminRootPage(),
      );
    },
    AppointmentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AppointmentDetailRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.AppointmentDetailPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    AppointmentListRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.AppointmentListPage(),
      );
    },
    DoctorDetailRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.DoctorDetailPage(),
      );
    },
    DoctorFormRoute.name: (routeData) {
      final args = routeData.argsAs<DoctorFormRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DoctorFormPage(
          args.id,
          key: args.key,
        ),
      );
    },
    DoctorListRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.DoctorListPage(),
      );
    },
    MemberDetailRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MemberDetailPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminFormPage]
class AdminFormRoute extends _i11.PageRouteInfo<AdminFormRouteArgs> {
  AdminFormRoute({
    _i12.Key? key,
    required String id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          AdminFormRoute.name,
          args: AdminFormRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'AdminFormRoute';

  static const _i11.PageInfo<AdminFormRouteArgs> page =
      _i11.PageInfo<AdminFormRouteArgs>(name);
}

class AdminFormRouteArgs {
  const AdminFormRouteArgs({
    this.key,
    required this.id,
  });

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'AdminFormRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.AdminHomePage]
class AdminHomeRoute extends _i11.PageRouteInfo<void> {
  const AdminHomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AdminHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AdminListPage]
class AdminListRoute extends _i11.PageRouteInfo<void> {
  const AdminListRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AdminListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminListRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AdminRootPage]
class AdminRootRoute extends _i11.PageRouteInfo<void> {
  const AdminRootRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AdminRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRootRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AppointmentDetailPage]
class AppointmentDetailRoute
    extends _i11.PageRouteInfo<AppointmentDetailRouteArgs> {
  AppointmentDetailRoute({
    _i12.Key? key,
    required String id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          AppointmentDetailRoute.name,
          args: AppointmentDetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'AppointmentDetailRoute';

  static const _i11.PageInfo<AppointmentDetailRouteArgs> page =
      _i11.PageInfo<AppointmentDetailRouteArgs>(name);
}

class AppointmentDetailRouteArgs {
  const AppointmentDetailRouteArgs({
    this.key,
    required this.id,
  });

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'AppointmentDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i6.AppointmentListPage]
class AppointmentListRoute extends _i11.PageRouteInfo<void> {
  const AppointmentListRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AppointmentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentListRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DoctorDetailPage]
class DoctorDetailRoute extends _i11.PageRouteInfo<void> {
  const DoctorDetailRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DoctorDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorDetailRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.DoctorFormPage]
class DoctorFormRoute extends _i11.PageRouteInfo<DoctorFormRouteArgs> {
  DoctorFormRoute({
    required String id,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          DoctorFormRoute.name,
          args: DoctorFormRouteArgs(
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DoctorFormRoute';

  static const _i11.PageInfo<DoctorFormRouteArgs> page =
      _i11.PageInfo<DoctorFormRouteArgs>(name);
}

class DoctorFormRouteArgs {
  const DoctorFormRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final _i12.Key? key;

  @override
  String toString() {
    return 'DoctorFormRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i9.DoctorListPage]
class DoctorListRoute extends _i11.PageRouteInfo<void> {
  const DoctorListRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DoctorListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorListRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MemberDetailPage]
class MemberDetailRoute extends _i11.PageRouteInfo<void> {
  const MemberDetailRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MemberDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberDetailRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
