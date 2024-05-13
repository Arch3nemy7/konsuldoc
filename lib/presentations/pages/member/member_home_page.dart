import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/widgets/doctor_search_bar.dart';
import 'package:konsuldoc/presentations/widgets/drawer/doctor_filter_drawer.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/theme_mode_switch.dart';

@RoutePage()
class MemberHomePage extends StatefulWidget {
  const MemberHomePage({super.key});

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  final doctors = List.generate(
    50,
    (index) => DoctorBasic(
      id: index.toString(),
      avatar:
          'https://img.freepik.com/premium-vector/avatar-bearded-doctor-doctor-with-stethoscope-vector-illustrationxa_276184-31.jpg',
      name: 'Dokter $index',
      specialist: 'Spesialis $index',
    ),
  );
  Specialist? specialist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      endDrawer: Drawer(
        child: DoctorFilterDrawer(
          value: specialist,
          onApply: (value) {
            setState(() {
              specialist = value;
            });
          },
        ),
      ),
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
                          'Hi, Budi Hariyanto',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'Temukan Spesialis Anda',
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: DoctorSearchBar(),
            ),
            SizedBox(
              height: 61,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(7),
                itemCount: Specialist.values.length,
                itemBuilder: (context, index) {
                  final data = Specialist.values[index];
                  final selected = specialist == data;

                  return OptionItem(
                    selected: selected,
                    onPressed: () {
                      setState(() {
                        specialist = selected ? null : data;
                      });
                    },
                    icon: data.icon,
                    activeIcon: data.activeIcon,
                    label: data.label,
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];

                  return ListItem(
                    avatar: doctor.avatar,
                    title: doctor.name,
                    subtitle: doctor.specialist,
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
