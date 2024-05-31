import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsuldoc/core/utils/comparator.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/appointment_session.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

class BottomsheetReschedule extends ConsumerStatefulWidget {
  final Appointment appointment;
  const BottomsheetReschedule({super.key, required this.appointment});

  @override
  ConsumerState<BottomsheetReschedule> createState() =>
      _BottomsheetRescheduleState();
}

class _BottomsheetRescheduleState extends ConsumerState<BottomsheetReschedule> {
  late DateTime date = widget.appointment.date;
  late int? session = widget.appointment.session;
  late final dates = getNext10Weekdays();

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  List<DateTime> getNext10Weekdays() {
    List<DateTime> weekdays = [];
    DateTime currentDate = DateTime.now().add(const Duration(days: 1));

    while (weekdays.length < 10) {
      if (!isWeekend(currentDate)) {
        weekdays.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return weekdays;
  }

  void changeDate(DateTime value) {
    if (date == value) return;

    setState(() {
      date = value;
      session = null;
    });
  }

  void changeSession(int value) {
    setState(() {
      session = value;
    });
  }

  void rescheduleAppointment() {
    ref
        .read(appointmentControllerProvider)
        .reschedule(widget.appointment.id, date, session!)
        .then((value) {
      if (value) context.maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ref
            .watch(fetchDoctorByIdProvider(widget.appointment.doctor.id))
            .when(
              data: (doctor) => ref
                  .watch(
                      fetchBookedSessionsProvider(widget.appointment.doctor.id))
                  .when(
                    data: (bookedSession) => SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            const Text('Re-Schedule',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            const Divider(
                              color: Colors.black38,
                              thickness: 1,
                            ),
                            const Text(
                              'Anda yakin ingin menjadwalkan\nulang janji temu Anda?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Tanggal',
                                style: GoogleFonts.inter().copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dates.length,
                                itemBuilder: (context, index) {
                                  final item = dates[index];
                                  final selected = item.isSameDate(date);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        changeDate(item);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: selected
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.background,
                                        foregroundColor: selected
                                            ? theme.colorScheme.onPrimary
                                            : theme.colorScheme.onBackground,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.toShortDayString(),
                                            style: GoogleFonts.inter().copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(item.day
                                              .toString()
                                              .padLeft(2, '0'))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Sesi',
                                style: GoogleFonts.inter().copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    doctor.schedules[date.weekday - 1].length,
                                itemBuilder: (context, index) {
                                  final item =
                                      doctor.schedules[date.weekday - 1][index];
                                  final selected = index == session;
                                  final booked = item.quota < 1 ||
                                      bookedSession.contains(AppointmentSession(
                                        date: date,
                                        session: index,
                                      ));

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: booked
                                          ? null
                                          : () {
                                              changeSession(index);
                                            },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: selected
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.background,
                                          foregroundColor: selected
                                              ? theme.colorScheme.onPrimary
                                              : theme.colorScheme.onBackground,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sesi ${index + 1}",
                                            style: GoogleFonts.inter().copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${item.timeStart.toTimeString()} - ${item.timeEnd.toTimeString()}",
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            PrimaryButton(
                              onPressed: rescheduleAppointment,
                              label: 'Simpan',
                            ),
                          ],
                        ),
                      ),
                    ),
                    error: (error, stackTrace) =>
                        ErrorView(message: error.toString()),
                    loading: () => const Loader(),
                  ),
              error: (error, stackTrace) =>
                  ErrorView(message: error.toString()),
              loading: () => const Loader(),
            );
      },
    );
  }
}
