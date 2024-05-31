import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart';

@AutoRouterConfig(generateForDir: [
  'lib/presentations/pages/doctor',
  'lib/presentations/pages/common',
])
class DoctorRouter extends $DoctorRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: DoctorRootRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            AutoRoute(page: DoctorHomeRoute.page),
            AutoRoute(page: DoctorAppointmentListRoute.page),
            AutoRoute(page: DoctorDetailRoute.page),
          ],
        ),
        CustomRoute(page: AppointmentDetailRoute.page),
        CustomRoute(page: MemberDetailRoute.page),
        CustomRoute(page: MemberHistoryRoute.page),
      ];
}
