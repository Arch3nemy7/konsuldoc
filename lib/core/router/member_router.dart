import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';

@AutoRouterConfig(generateForDir: [
  'lib/presentations/pages/member',
  'lib/presentations/pages/common',
])
class MemberRouter extends $MemberRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: MemberRootRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            AutoRoute(page: MemberHomeRoute.page),
            AutoRoute(page: AppointmentListRoute.page),
            AutoRoute(page: MemberProfileRoute.page),
          ],
        ),
        CustomRoute(page: DoctorDetailRoute.page),
        CustomRoute(page: MemberDetailRoute.page),
        CustomRoute(page: AppointmentDetailRoute.page),
        CustomRoute(page: CreateAppointmentRoute.page),
        CustomRoute(page: AppointmentDetailRoute.page),
        CustomRoute(page: MemberFormRoute.page),
        CustomRoute(page: MemberHistoryRoute.page),
      ];
}
