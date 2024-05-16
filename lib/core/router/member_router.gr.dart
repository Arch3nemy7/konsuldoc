// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:konsuldoc/presentations/pages/member/member_home_page.dart'
    as _i1;

abstract class $MemberRouter extends _i2.RootStackRouter {
  $MemberRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MemberHomeRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MemberHomePage(),
      );
    }
  };
}

/// generated route for
/// [_i1.MemberHomePage]
class MemberHomeRoute extends _i2.PageRouteInfo<void> {
  const MemberHomeRoute({List<_i2.PageRouteInfo>? children})
      : super(
          MemberHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberHomeRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
