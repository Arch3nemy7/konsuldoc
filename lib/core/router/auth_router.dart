import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends $AuthRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SignInRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: SignUpRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          initial: true,
          page: OnBoardingRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ];
}
