import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_filter.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_view.dart';

class DoctorSession {
  TimeOfDay timeStart;
  TimeOfDay timeEnd;

  DoctorSession({
    required this.timeStart,
    required this.timeEnd,
  });
}

@RoutePage()
class AppointmentListPage extends ConsumerStatefulWidget {
  const AppointmentListPage({super.key});

  @override
  ConsumerState<AppointmentListPage> createState() =>
      _AppointmentListPageState();
}

class _AppointmentListPageState extends ConsumerState<AppointmentListPage> {
  final _pagingController = PagingController<int, Appointment>(firstPageKey: 1);
  AppointmentFilter filter = AppointmentFilter.upcoming;

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<Appointment>> fetchData(int page, int perPage) {
    return ref.read(appointmentRepositoryProvider).fetch(
          memberId: ref.read(authStateProvider)?.id,
          filter: filter,
          page: page,
          perPage: perPage,
        );
  }

  void updateFilter(AppointmentFilter value) {
    if (value == filter) return;

    setState(() {
      filter = value;
    });
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    DoctorSession session = DoctorSession(
      timeStart: const TimeOfDay(hour: 9, minute: 0),
      timeEnd: const TimeOfDay(hour: 10, minute: 0),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14).copyWith(bottom: 0),
              child: Text(
                'Daftar janji temu',
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 63,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    ...(AppointmentFilter.values.map(
                      (e) => OptionItem(
                        selected: filter == e,
                        onPressed: () => updateFilter(e),
                        label: e.label,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: PaginatedView(
                pagingController: _pagingController,
                perPage: 10,
                fetchData: fetchData,
                child: PagedListView(
                  pagingController: _pagingController,
                  builderDelegate: PaginatedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      return ListItem(
                        onTap: () {
                          context.pushRoute(
                            AppointmentDetailRoute(id: item.id),
                          );
                        },
                        avatar: item.doctor.avatar,
                        title: item.doctor.name,
                        subtitle: item.doctor.specialist.label,
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFA4CFC3),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "#${item.number}",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Sesi ${item.session + 1}",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${session.timeStart.format(context)} - ${session.timeEnd.format(context)}",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: Text(
                          item.date.toDateString(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    pagingController: _pagingController,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
