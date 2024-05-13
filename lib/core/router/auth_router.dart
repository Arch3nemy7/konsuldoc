import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/auth_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentations/pages/auth'])
class AuthRouter extends $AuthRouter {
  @override
  List<AutoRoute> get routes => [];
}
