import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment_session.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

@RoutePage()
class CreateAppointmentPage extends ConsumerStatefulWidget {
  final String idDoctor;
  const CreateAppointmentPage({super.key, required this.idDoctor});

  @override
  ConsumerState<CreateAppointmentPage> createState() =>
      _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends ConsumerState<CreateAppointmentPage> {
  final TextEditingController _complaintsController = TextEditingController();

  int? session;
  DateTime? date;
  late final dates = getNext10Weekdays();

  @override
  void dispose() {
    _complaintsController.dispose();
    super.dispose();
  }

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

  void createAppointment() {
    final complaints = _complaintsController.text;

    if (date == null) {
      BotToast.showText(text: 'Harap memilih tanggal');
      return;
    }
    if (session == null) {
      BotToast.showText(text: 'Harap memilih sesi');
      return;
    }

    ref
        .read(appointmentControllerProvider)
        .add(widget.idDoctor, date!, session!, complaints)
        .then((value) {
      if (value != null) {
        print(value);
        context.replaceRoute(AppointmentDetailRoute(id: value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Janji',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ref.watch(fetchDoctorByIdProvider(widget.idDoctor)).when(
            data: (doctor) => ref
                .watch(fetchBookedSessionsProvider(widget.idDoctor))
                .when(
                    data: (bookedSession) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 124.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: kElevationToShadow[4],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                          NetworkImage(doctor.avatar!),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doctor.name,
                                          style: const TextStyle(
                                            color: Color(0xFF1F2A37),
                                            fontSize: 20.0,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                          ),
                                        ),
                                        const Divider(),
                                        Text(
                                          doctor.specialist.label,
                                          style: const TextStyle(
                                            color: Color(0xFF4B5563),
                                            fontSize: 14.0,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Tentang Dokter',
                                style: GoogleFonts.inter().copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpandableText(
                                doctor.about,
                                maxLines: 2,
                                animationDuration:
                                    const Duration(milliseconds: 500),
                                expandText: 'lihat selengkapnya',
                                collapseText: 'lihat lebih sedikit',
                                style: GoogleFonts.inter().copyWith(
                                  color: theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  final selected = item == date;

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
                                            item.toDayString(),
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
                                itemCount: date == null
                                    ? 0
                                    : doctor
                                        .schedules[date!.weekday - 1].length,
                                itemBuilder: (context, index) {
                                  final item = doctor
                                      .schedules[date!.weekday - 1][index];
                                  final selected = index == session;
                                  final booked =
                                      bookedSession.contains(AppointmentSession(
                                    date: date!,
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
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _complaintsController,
                              decoration: const InputDecoration(
                                labelText: 'Keluhan / Gejala',
                                hintText: 'Masukkan keluhan sakit...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              onPressed: createAppointment,
                              label: 'Buat Janji',
                            ),
                          ],
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        ErrorView(message: error.toString()),
                    loading: () => const Loader()),
            error: (error, stackTrace) => ErrorView(message: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
