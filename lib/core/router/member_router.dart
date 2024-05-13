import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentations/pages/member'])
class MemberRouter extends $MemberRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MemberHomeRoute.page, initial: true),
      ];
}
