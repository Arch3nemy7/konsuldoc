import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Anda yakin ingin menjadwalkan',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1)),
                                  ),
                                  Text(
                                    'ulang janji temu Anda?',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Jadwal',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Container(
                                          width: 140,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey,
                                          ),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  widget.appointment.session
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${doctor.schedules[widget.appointment.date.weekday - 1][widget.appointment.session].timeStart.toTimeString()} - ${doctor.schedules[widget.appointment.date.weekday - 1][widget.appointment.session].timeEnd.toTimeString()}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                        child: const Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                '24 April 2024',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                      itemCount: doctor
                                          .schedules[date.weekday - 1].length,
                                      itemBuilder: (context, index) {
                                        final item = doctor
                                            .schedules[date.weekday - 1][index];
                                        final selected = index == session;
                                        final booked = bookedSession
                                            .contains(AppointmentSession(
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
                                                    : theme
                                                        .colorScheme.background,
                                                foregroundColor: selected
                                                    ? theme
                                                        .colorScheme.onPrimary
                                                    : theme.colorScheme
                                                        .onBackground,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Sesi ${index + 1}",
                                                  style: GoogleFonts.inter()
                                                      .copyWith(
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
                                ]),
                            PrimaryButton(
                                onPressed: rescheduleAppointment,
                                label: 'Simpan'),
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
