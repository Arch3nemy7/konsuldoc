// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:konsuldoc/presentations/pages/admin/admin_home_page.dart'
    as _i1;

abstract class $AdminRouter extends _i2.RootStackRouter {
  $AdminRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AdminHomeRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AdminHomePage(),
      );
    }
  };
}

/// generated route for
/// [_i1.AdminHomePage]
class AdminHomeRoute extends _i2.PageRouteInfo<void> {
  const AdminHomeRoute({List<_i2.PageRouteInfo>? children})
      : super(
          AdminHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomeRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
