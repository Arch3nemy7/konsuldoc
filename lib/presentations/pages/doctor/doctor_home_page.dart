import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_view.dart';
import 'package:konsuldoc/presentations/widgets/theme_mode_switch.dart';

@RoutePage()
class DoctorHomePage extends ConsumerStatefulWidget {
  const DoctorHomePage({super.key});

  @override
  ConsumerState<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends ConsumerState<DoctorHomePage> {
  late final currentlyWeekend = isWeekend(DateTime.now());
  final _pagingController = PagingController<int, Appointment>(firstPageKey: 1);
  bool sessionStarted = false;

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  bool isAfter(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour > t2.hour || (t1.hour == t2.hour && t1.minute > t2.minute);
  }

  int? getSession(List<List<DoctorSession>> schedules) {
    if (currentlyWeekend) return null;

    final date = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();
    final day = date.weekday - 1;

    for (var i = 0; i < schedules[day].length; i++) {
      if (isAfter(schedules[day][i].timeEnd, currentTime)) return i;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ref.watch(userStateProvider).when(
              data: (data) {
                final doctor = data as Doctor;
                final date = DateTime.now();
                final day = date.weekday - 1;
                final session = getSession(doctor.schedules);
                final sessionData =
                    session == null ? null : doctor.schedules[day][session];

                Future<List<Appointment>> fetchData(int page, int perPage) {
                  return ref.read(appointmentRepositoryProvider).fetch(
                        doctorId: doctor.id,
                        date: date,
                        session: session,
                        page: page,
                        perPage: perPage,
                      );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22)
                          .copyWith(bottom: 14, right: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  date.toDateString(),
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  sessionData == null
                                      ? 'Tidak ada sesi untuk hari ini'
                                      : "Sesi ${session! + 1}\t${sessionData.timeStart.toTimeString()}-${sessionData.timeEnd.toTimeString()}",
                                  style: theme.textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const ThemeModeSwitch()
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: sessionData == null
                          ? const Center(
                              child: Text(
                                "Selamat beristirahat",
                              ),
                            )
                          : sessionStarted
                              ? PaginatedView(
                                  pagingController: _pagingController,
                                  perPage: 10,
                                  fetchData: fetchData,
                                  child: PagedListView(
                                    pagingController: _pagingController,
                                    builderDelegate:
                                        PaginatedChildBuilderDelegate(
                                      emptyMessage: 'Tidak ada jadwal',
                                      itemBuilder: (context, item, index) =>
                                          ListItem(
                                        onTap: () {
                                          context.pushRoute(
                                            AppointmentDetailRoute(
                                              id: item.id,
                                              canConfirm: true,
                                            ),
                                          );
                                        },
                                        avatar: item.member.avatar,
                                        title: item.member.name,
                                        subtitle: item.status.label,
                                        enabled: item.status ==
                                            AppointmentStatus.waiting,
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(8.0)
                                              .copyWith(left: 16),
                                          child: Text(
                                              "#${item.number.toString()}"),
                                        ),
                                      ),
                                      pagingController: _pagingController,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: PrimaryButton(
                                      onPressed: isAfter(TimeOfDay.now(),
                                              sessionData.timeStart)
                                          ? () {
                                              setState(() {
                                                sessionStarted = true;
                                              });
                                            }
                                          : null,
                                      label: 'Mulai sesi',
                                    ),
                                  ),
                                ),
                    )
                  ],
                );
              },
              error: (error, stackTrace) {
                return ErrorView(
                  message: error.toString(),
                );
              },
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
