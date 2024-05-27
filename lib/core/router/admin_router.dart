import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/admin_router.gr.dart';

@AutoRouterConfig(generateForDir: [
  'lib/presentations/pages/admin',
  'lib/presentations/pages/common',
])
class AdminRouter extends $AdminRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: AdminRootRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            AutoRoute(page: DoctorListRoute.page),
            AutoRoute(page: AdminListRoute.page),
          ],
        ),
        CustomRoute(page: AppointmentDetailRoute.page),
        CustomRoute(page: MemberDetailRoute.page),
        CustomRoute(page: DoctorDetailRoute.page),
        CustomRoute(page: DoctorFormRoute.page),
        CustomRoute(page: AdminFormRoute.page),
      ];
}
