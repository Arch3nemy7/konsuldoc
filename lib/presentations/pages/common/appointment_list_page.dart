import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/entities/member_basic.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';

@RoutePage()
class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({super.key});

  @override
  State<AppointmentListPage> createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  final appointmentList = List.generate(
      30,
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
            status: AppointmentStatus.waiting,
          ));
  bool upcoming = true;
  AppointmentStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14).copyWith(bottom: 0),
              child: Text(
                'Pilih status janji temu',
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 63,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    OptionItem(
                      selected: upcoming,
                      onPressed: () {
                        if (!upcoming) {
                          setState(() {
                            upcoming = true;
                            status = null;
                          });
                        }
                      },
                      label: 'Mendatang',
                    ),
                    ...(AppointmentStatus.values.map(
                      (e) => OptionItem(
                        selected: status == e,
                        onPressed: () => setState(() {
                          if (upcoming) upcoming = false;
                          status = e;
                        }),
                        label: e.name,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7),
                itemCount: appointmentList.length,
                itemBuilder: (context, index) {
                  final appointment = appointmentList[index];

                  return ListItem(
                    avatar: appointment.doctor.avatar,
                    title: appointment.doctor.name,
                    subtitle: appointment.doctor.specialist.label,
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
