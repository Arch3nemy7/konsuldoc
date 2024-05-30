import 'package:auto_route/auto_route.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart' as member_router;
import 'package:konsuldoc/core/router/doctor_router.gr.dart' as doctor_router;
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/reschedule_bottomsheet.dart';

@RoutePage()
class AppointmentDetailPage extends ConsumerStatefulWidget {
  final String id;
  final bool canConfirm;
  const AppointmentDetailPage({
    super.key,
    required this.id,
    this.canConfirm = false,
  });

  @override
  ConsumerState<AppointmentDetailPage> createState() =>
      _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends ConsumerState<AppointmentDetailPage> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool isAfter(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour > t2.hour || (t1.hour == t2.hour && t1.minute > t2.minute);
  }

  void _showRescheduleBottomSheet(
    BuildContext context,
    Appointment appointment,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomsheetReschedule(
          appointment: appointment,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final role = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Janji Temu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ref.watch(fetchAppointmentByIdProvider(widget.id)).when(
            data: (appointment) => ref
                .watch(fetchDoctorByIdProvider(appointment.doctor.id))
                .when(
                  data: (doctor) {
                    final session =
                        doctor.schedules[appointment.date.weekday - 1]
                            [appointment.session];
                    final timeLimit = DateTime(
                      appointment.date.year,
                      appointment.date.month,
                      appointment.date.day,
                      session.timeStart.hour,
                      session.timeStart.minute,
                    );

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Dokter',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (role == Role.member) {
                                context.pushRoute(
                                  member_router.DoctorDetailRoute(
                                    id: appointment.doctor.id,
                                  ),
                                );
                              } else {
                                context.pushRoute(
                                  doctor_router.DoctorDetailRoute(
                                    id: appointment.doctor.id,
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(appointment.doctor.avatar!),
                                  radius: 50,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment.doctor.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 10.0,
                                      height: 10,
                                    ),
                                    Text(
                                      appointment.doctor.specialist.label,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Pasien',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (role == Role.member) {
                                context.pushRoute(
                                  member_router.MemberDetailRoute(
                                    id: appointment.member.id,
                                  ),
                                );
                              } else {
                                context.pushRoute(
                                  doctor_router.MemberDetailRoute(
                                    id: appointment.member.id,
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      appointment.member.avatar == null
                                          ? null
                                          : NetworkImage(
                                              appointment.member.avatar!,
                                            ),
                                  radius: 50,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment.member.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 10.0,
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Waktu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  disabledForegroundColor:
                                      theme.colorScheme.onBackground,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text("Sesi ${appointment.session + 1}"),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  disabledForegroundColor:
                                      theme.colorScheme.onBackground,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                    "${session.timeStart.toTimeString()} - ${session.timeEnd.toTimeString()}"),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    disabledForegroundColor:
                                        theme.colorScheme.onBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    appointment.date.toDateString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Keluhan / Gejala',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ExpandableText(
                            appointment.complaints ?? 'Tidak ada',
                            maxLines: 2,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            expandText: 'lihat selengkapnya',
                            collapseText: 'lihat lebih sedikit',
                            style: TextStyle(
                              color: theme.colorScheme.onBackground
                                  .withOpacity(0.7),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (!widget.canConfirm ||
                              appointment.status == AppointmentStatus.done)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Catatan dokter',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ExpandableText(
                                  appointment.note ?? 'Tidak ada',
                                  maxLines: 2,
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  expandText: 'lihat selengkapnya',
                                  collapseText: 'lihat lebih sedikit',
                                  style: TextStyle(
                                    color: theme.colorScheme.onBackground
                                        .withOpacity(0.7),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 15),
                          if (role == Role.doctor &&
                              appointment.status == AppointmentStatus.waiting &&
                              widget.canConfirm)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _noteController,
                                  maxLines: null,
                                  enabled: role == Role.doctor &&
                                      appointment.status ==
                                          AppointmentStatus.waiting &&
                                      widget.canConfirm,
                                  decoration: const InputDecoration(
                                    labelText: 'Catatan dokter',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                PrimaryButton(
                                  onPressed: () {
                                    ref
                                        .read(appointmentControllerProvider)
                                        .editStatus(
                                          widget.id,
                                          note: _noteController.text,
                                          status: AppointmentStatus.done,
                                        );
                                  },
                                  label: "Konfirmasi",
                                )
                              ],
                            ),
                          if (role == Role.member &&
                              appointment.status == AppointmentStatus.waiting)
                            PrimaryButton(
                              onPressed: DateTime.now().isBefore(timeLimit
                                      .subtract(const Duration(hours: 1)))
                                  ? () {
                                      _showRescheduleBottomSheet(
                                        context,
                                        appointment,
                                      );
                                    }
                                  : null,
                              label: 'Ubah jadwal',
                            )
                        ],
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      const Text('Data tidak ditemukan'),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            error: (error, stackTrace) => const Text('Data tidak ditemukan'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
