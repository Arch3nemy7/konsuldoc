import 'package:auto_route/auto_route.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';

@RoutePage()
class DoctorDetailPage extends ConsumerStatefulWidget {
  final String doctorId;

  const DoctorDetailPage({super.key, required this.doctorId});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends ConsumerState<DoctorDetailPage> {
  void updateDoctorDetail() async {
    final doctorController = ref.read(doctorControllerProvider);
    final result = await doctorController.edit(
      widget.doctorId,
      name: "Updated Name",
      email: "updated.email@example.com",
      specialist: Specialist.cardiology,
      phone: "1234567890",
      about: "Updated about text",
      schedules: [],
    );
    if (result) {
      context.maybePop();
    }
  }

  void deleteDoctor() async {
    final doctorController = ref.read(authControllerProvider);
    final result = await doctorController.deleteUser(widget.doctorId);
    if (result) {
      context.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorFuture = ref.watch(fetchDoctorByIdProvider(widget.doctorId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Dokter'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FAFE),
      ),
      body: doctorFuture.when(
        data: (doctor) {
          return SingleChildScrollView(
            child: Padding(
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
                            backgroundImage: doctor.avatar != null
                                ? NetworkImage(doctor.avatar!)
                                : AssetImage('assets/default_avatar.png')
                                    as ImageProvider,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tentang Dokter',
                      style: TextStyle(
                        color: Colors.black,
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
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Jadwal Praktik',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: 0.10,
                      ),
                    ),
                  ),
                  ...doctor.schedules.asMap().entries.map((entry) {
                    final dayIndex = entry.key;
                    final sessions = entry.value;
                    final dayName = _getDayName(dayIndex);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          ...sessions.map((session) {
                            return Text(
                              '${session.timeStart.format(context)} - ${session.timeEnd.format(context)} (Quota: ${session.quota})',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol Buat Janji ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004C69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      child: const Text(
                        'Buat Janji',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text('Error loading data')),
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'SENIN';
      case 1:
        return 'SELASA';
      case 2:
        return 'RABU';
      case 3:
        return 'KAMIS';
      case 4:
        return 'JUMAT';
      default:
        return 'Unknown';
    }
  }
}
