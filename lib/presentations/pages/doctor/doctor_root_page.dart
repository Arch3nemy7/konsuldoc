import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';

@RoutePage()
class DoctorRootPage extends ConsumerWidget {
  const DoctorRootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: [
        const DoctorHomeRoute(),
        const AppointmentListRoute(),
        DoctorDetailRoute(doctorId: ref.watch(authStateProvider)!.id),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => NavigationBar(
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: tabsRouter.setActiveIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Janji temu',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
