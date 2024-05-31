import 'package:auto_route/auto_route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:konsuldoc/core/constants/hive_constants.dart';
import 'package:konsuldoc/core/router/auth_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentations/pages/auth'])
class AuthRouter extends $AuthRouter {
  final _box = Hive.box(HiveConstants.box);

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: _box.get(HiveConstants.onboarding, defaultValue: false),
          page: SignInRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: SignUpRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          initial: !_box.get(HiveConstants.onboarding, defaultValue: false),
          page: OnBoardingRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ];
}
