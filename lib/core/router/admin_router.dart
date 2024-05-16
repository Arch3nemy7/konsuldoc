import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/admin_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentations/pages/admin'])
class AdminRouter extends $AdminRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AdminHomeRoute.page, initial: true),
      ];
}
