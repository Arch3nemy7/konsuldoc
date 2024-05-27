import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/entities/member_basic.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/widgets/section/doctor_feed_item.dart';
import 'package:konsuldoc/presentations/widgets/theme_mode_switch.dart';

@RoutePage()
class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final appointments = List.generate(
    50,
    (index) => Appointment(
      id: index.toString(),
      member: MemberBasic(
        id: index.toString(),
        avatar: 'https://i.pravatar.cc/300?u=$index',
        name: 'Member $index',
      ),
      doctor: DoctorBasic(
        id: index.toString(),
        avatar: 'https://i.pravatar.cc/300?u=d$index',
        name: 'Doctor $index',
        specialist: Specialist.cardiology,
      ),
      date: DateTime.now(),
      session: 0,
      status: AppointmentStatus.pending,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22).copyWith(bottom: 14, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Doctor',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'Lihat jadwal anda',
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
              child: ListView(
                children: [
                  DoctorFeedItem(
                    title: 'Hari ini',
                    trailing: '4 Mei 2024',
                    appointments: appointments.take(2).toList(),
                  ),
                  DoctorFeedItem(
                    title: 'Besok',
                    trailing: '5 Mei 2024',
                    appointments: appointments.take(2).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
