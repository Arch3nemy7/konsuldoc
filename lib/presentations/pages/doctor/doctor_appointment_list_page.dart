import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart';
import 'package:konsuldoc/core/utils/comparator.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_view.dart';

@RoutePage()
class DoctorAppointmentListPage extends ConsumerStatefulWidget {
  const DoctorAppointmentListPage({super.key});

  @override
  ConsumerState<DoctorAppointmentListPage> createState() =>
      _AppointmentListPageState();
}

class _AppointmentListPageState
    extends ConsumerState<DoctorAppointmentListPage> {
  final _pagingController = PagingController<int, Appointment>(firstPageKey: 1);
  late final dates = getNextFiveDays();
  DateTime date = DateTime.now();

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  List<DateTime> getNextFiveDays() {
    List<DateTime> weekdays = [];
    DateTime currentDate = DateTime.now();

    while (weekdays.length < 5) {
      if (!isWeekend(currentDate)) {
        weekdays.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return weekdays;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<Appointment>> fetchData(int page, int perPage) {
    return ref.read(appointmentRepositoryProvider).fetch(
          doctorId: ref.read(authStateProvider)?.id,
          date: date,
          page: page,
          perPage: perPage,
        );
  }

  void updateDate(DateTime value) {
    if (date.isSameDate(value)) return;

    setState(() {
      date = value;
    });
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    ...(dates.map(
                      (e) => OptionItem(
                        selected: date.isSameDate(e),
                        onPressed: () => updateDate(e),
                        label: e.toDayString(),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ref.watch(userStateProvider).when(
                    data: (doctor) => PaginatedView(
                      pagingController: _pagingController,
                      perPage: 10,
                      fetchData: fetchData,
                      child: PagedListView(
                        pagingController: _pagingController,
                        builderDelegate: PaginatedChildBuilderDelegate(
                          emptyTitle: 'Tidak Ada Janji',
                          emptyMessage:
                              'Tidak ada pasien yang mendaftar pada hari ini, silahkan tunggu dihari berikutnya!',
                          itemBuilder: (context, item, index) {
                            final session = (doctor as Doctor)
                                .schedules[item.date.weekday - 1][item.session];

                            return ListItem(
                              onTap: () {
                                context.pushRoute(
                                  AppointmentDetailRoute(id: item.id),
                                );
                              },
                              avatar: item.member.avatar,
                              title: item.member.name,
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "#${item.number}",
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Sesi ${item.session + 1}",
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${session.timeStart.toTimeString()} - ${session.timeEnd.toTimeString()}",
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
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
                    error: (error, stackTrace) =>
                        ErrorView(message: error.toString()),
                    loading: () => const Loader(),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
