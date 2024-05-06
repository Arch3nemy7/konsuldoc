import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/router/auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends $AuthRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SignInRoute.page,
          initial: true,
        )
      ];
}
