import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
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
      body: ref.watch(userStateProvider).when(
            data: (data) {
              final member = data as Member;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 250,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${member.name}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'Temukan Spesialis Anda',
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    actions: const [ThemeModeSwitch()],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        margin: const EdgeInsets.all(20.0).copyWith(top: 100),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[4],
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Utamakan untuk selalu periksa!',
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Jadwalkan appointment dan konsultasi dengan dokter secara langsung.',
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    primary: false,
                    pinned: true,
                    titleSpacing: 0,
                    toolbarHeight: 120,
                    actions: const [SizedBox()],
                    title: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14)
                            .copyWith(top: 10),
                        child: DoctorSearchBar(
                          onSubmitted: search,
                        ),
                      ),
                      SizedBox(
                        height: 61,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                    ]),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: ref.watch(fetchAllDoctorProvider).when(
                          data: (data) {
                            final filtered = data.filter((t) {
                              if (query != null && !t.name.contains(query!)) {
                                return false;
                              }
                              if (specialist != null &&
                                  t.specialist != specialist) {
                                return false;
                              }

                              return true;
                            }).toList();

                            return ListView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final doctor = filtered[index];

                                return ListItem(
                                  onTap: () => context.pushRoute(
                                      DoctorDetailRoute(id: doctor.id)),
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
                  )
                ],
              );
            },
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
