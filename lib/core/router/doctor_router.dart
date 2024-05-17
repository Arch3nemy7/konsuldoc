import 'package:auto_route/auto_route.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentations/pages/doctor'])
class DoctorRouter extends $DoctorRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: DoctorHomeRoute.page, initial: true),
      ];
}
