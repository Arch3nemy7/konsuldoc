import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/entities/member_basic.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/theme_mode_switch.dart';

@RoutePage()
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
        specialist: 'Spesialis $index',
      ),
      date: DateTime.now(),
      status: AppointmentStatus.pending,
    ),
  );
  AppointmentStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22).copyWith(bottom: 0, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Admin',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'Pilih status janji temu',
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
            SizedBox(
              height: 61,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(7),
                itemCount: AppointmentStatus.values.length,
                itemBuilder: (context, index) {
                  final data = AppointmentStatus.values[index];
                  final selected = status == data;

                  return OptionItem(
                    selected: selected,
                    onPressed: () {
                      setState(() {
                        status = selected ? null : data;
                      });
                    },
                    label: data.label,
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];

                  return ListItem(
                    avatar: appointment.member.avatar,
                    title: appointment.member.name,
                    subtitle: appointment.doctor.name,
                    bottom: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.schedule, size: 15),
                        const SizedBox(width: 3.5),
                        Text(
                          appointment.date.toTimeString(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          appointment.date.toDateString(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
