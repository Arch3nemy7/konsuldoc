import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/core/router/admin_router.gr.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/doctor_search_bar.dart';
import 'package:konsuldoc/presentations/widgets/drawer/doctor_filter_drawer.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

@RoutePage()
class DoctorListPage extends ConsumerStatefulWidget {
  const DoctorListPage({super.key});

  @override
  ConsumerState<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends ConsumerState<DoctorListPage> {
  String? query;
  Specialist? specialist;
  List<String> doctorNames = ['Dr. Mariya Khan'];

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dokter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authControllerProvider).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DoctorSearchBar(
              onSubmitted: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ref.watch(fetchAllDoctorProvider).when(
                  data: (data) {
                    final filtered = data.filter((t) {
                      if (query != null &&
                          !t.name
                              .toLowerCase()
                              .contains(query!.toLowerCase())) {
                        return false;
                      }
                      if (specialist != null && t.specialist != specialist) {
                        return false;
                      }

                      return true;
                    }).toList();

                    if (filtered.isEmpty) {
                      return const ErrorView(message: 'Data tidak ditemukan');
                    }

                    return ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final doctor = filtered[index];

                        return ListTile(
                          onTap: () {
                            context.pushRoute(DoctorFormRoute(doctor: doctor));
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          leading: CircleAvatar(
                            backgroundImage: doctor.avatar == null
                                ? null
                                : NetworkImage(doctor.avatar!),
                            radius: 25,
                          ),
                          title: Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            doctor.specialist.label,
                          ),
                        );
                      },
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'doctor-list',
        onPressed: () {
          context.pushRoute(DoctorFormRoute());
        },
        backgroundColor: const Color(0xFFF9E287),
        child: const Icon(Icons.add),
      ),
    );
  }
}
