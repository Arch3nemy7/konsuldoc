import 'package:auto_route/auto_route.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konsuldoc/core/constants/constants.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

@RoutePage()
class DoctorDetailPage extends ConsumerWidget {
  final String id;

  const DoctorDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authStateProvider);
    final role = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Text('Dokter'),
        actions: [
          if (user?.id == id)
            IconButton(
              onPressed: () {
                ref.read(authControllerProvider).signOut();
              },
              icon: const Icon(Icons.logout),
            )
        ],
        centerTitle: true,
      ),
      body: ref.watch(fetchDoctorByIdProvider(id)).when(
            data: (doctor) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 124.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: theme.colorScheme.background,
                        boxShadow: kElevationToShadow[4],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(doctor.avatar!),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                const Divider(),
                                Text(
                                  doctor.specialist.label,
                                  style: TextStyle(
                                    color: theme.colorScheme.onBackground
                                        .withOpacity(0.7),
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
                    const SizedBox(
                        height:
                            24), // Memberikan jarak antara card dan teks "Tentang Dokter"
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tentang Dokter',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpandableText(
                        doctor.about,
                        maxLines: 2,
                        animationDuration: const Duration(milliseconds: 500),
                        expandText: 'lihat selengkapnya',
                        collapseText: 'lihat lebih sedikit',
                        style: TextStyle(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.7),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            24), // Memberikan jarak antara "Tentang Dokter" dan "Jadwal Praktik"
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Jadwal Praktik',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.all(color: theme.dividerColor),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          for (var i = 0; i < doctor.schedules.length; i++) ...[
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Constants.days[i],
                                  style: GoogleFonts.inter().copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: doctor.schedules[i].isEmpty
                                      ? [const Text('Libur')]
                                      : doctor.schedules[i].map((session) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Sesi ${doctor.schedules[i].indexOf(session) + 1}"),
                                                Text(
                                                    "${session.timeStart.toTimeString()}-${session.timeEnd.toTimeString()}")
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                ),
                              ),
                            ])
                          ]
                        ],
                      ),
                    ),
                    if (role == Role.member)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: PrimaryButton(
                          onPressed: () {
                            context.pushRoute(
                                CreateAppointmentRoute(idDoctor: id));
                          },
                          label: 'Buat Janji',
                        ),
                      ),
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) {
              return ErrorView(
                message: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
