import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/doctor_search_bar.dart';
import 'package:konsuldoc/presentations/widgets/drawer/doctor_filter_drawer.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';
import 'package:konsuldoc/presentations/widgets/theme_mode_switch.dart';

@RoutePage()
class MemberHomePage extends ConsumerStatefulWidget {
  const MemberHomePage({super.key});

  @override
  ConsumerState<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends ConsumerState<MemberHomePage> {
  String? query;
  Specialist? specialist;

  void search(String value) {
    setState(() {
      query = value;
    });
  }

  void selectSpecialist(Specialist? value) {
    setState(() {
      specialist = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      endDrawer: Drawer(
        child: DoctorFilterDrawer(
          value: specialist,
          onApply: selectSpecialist,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DoctorSearchBar(
                onSubmitted: search,
              ),
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
                      selectSpecialist(selected ? null : data);
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
              child: ref.watch(fetchAllDoctorProvider).when(
                    data: (data) {
                      final filtered = data.filter((t) {
                        if (query != null && !t.name.contains(query!)) {
                          return false;
                        }
                        if (specialist != null && t.specialist != specialist) {
                          return false;
                        }

                        return true;
                      }).toList();

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final doctor = filtered[index];

                          return ListItem(
                            avatar: doctor.avatar,
                            title: doctor.name,
                            subtitle: doctor.specialist.label,
                          );
                        },
                        itemCount: filtered.length,
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorView(message: error.toString());
                    },
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
