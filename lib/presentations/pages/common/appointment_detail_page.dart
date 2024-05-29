import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/reschedule_bottomsheet.dart';

@RoutePage()
class AppointmentDetailPage extends ConsumerWidget {
  final String id;
  const AppointmentDetailPage({
    super.key,
    required this.id,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ref.watch(userStateProvider).when(
            data: (user) => ref.watch(fetchAppointmentByIdProvider(id)).when(
                  data: (appointment) => ref
                      .watch(fetchDoctorByIdProvider(appointment.doctor.id))
                      .when(
                        data: (doctor) {
                          final session =
                              doctor.schedules[appointment.date.weekday - 1]
                                  [appointment.session];

                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Dokter',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushRoute(
                                      DoctorDetailRoute(
                                          id: appointment.doctor.id),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            appointment.doctor.avatar!),
                                        radius: 50,
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(appointment.doctor.name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const Divider(
                                            color: Colors.black,
                                            thickness: 10.0,
                                            height: 10,
                                          ),
                                          Text(
                                              appointment
                                                  .doctor.specialist.label,
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                              )),
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
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushRoute(
                                      MemberDetailRoute(
                                        id: appointment.member.id,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            appointment.member.avatar == null
                                                ? null
                                                : NetworkImage(
                                                    appointment.member.avatar!),
                                        radius: 50,
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            appointment.member.name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black,
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
                                      color: Colors.black,
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
                                        disabledForegroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:
                                          Text("Sesi ${appointment.session}"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        disabledForegroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          disabledForegroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          appointment.date.toDateString(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (user!.role == Role.member &&
                                    DateTime.now().compareTo(appointment.date) <
                                        0)
                                  PrimaryButton(
                                    onPressed: () {
                                      _showRescheduleBottomSheet(
                                        context,
                                        appointment,
                                      );
                                    },
                                    label: 'Ubah jadwal',
                                  ),
                                if (user.role == Role.doctor &&
                                    appointment.status ==
                                        AppointmentStatus.waiting)
                                  PrimaryButton(
                                    onPressed: () {},
                                    label: "Konfirmasi",
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
