import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/presentations/controllers/appointment_controller.dart';

@RoutePage()
class AppointmentDetailPage extends ConsumerWidget {
  final String id;
  const AppointmentDetailPage({
    super.key,
    required this.id,
  });

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
      body: ref.watch(fetchAppointmentByIdProvider(id)).when(
            data: (appointment) => Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          'Doctor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appointment.doctor.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Divider(
                              color: Colors.black,
                              thickness: 10.0,
                              height: 10,
                            ),
                            Text(appointment.doctor.specialist,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tentang Saya',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'data.doctor.tentangsaya',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          'Pasien',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appointment.member.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Divider(
                              color: Colors.black,
                              thickness: 10.0,
                              height: 10,
                            ),
                            Text('data.member.umur',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jadwal',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 120,
                              child: TextButton(
                                onPressed: () {
                                  // Tambahkan fungsi untuk tombol jam praktik di sini
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.grey; // Warna latar abu-abu
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius 10
                                    ),
                                  ),
                                ),
                                child: Text(
                                  appointment.session.toString(),
                                  style: TextStyle(
                                      color: Colors.white), // Warna teks putih
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Tambahkan fungsi untuk tombol hari yang dipilih di sini
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.grey; // Warna latar abu-abu
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Border radius 10
                                  ),
                                ),
                              ),
                              child: Text(
                                appointment.date.toDateString(),
                                style: TextStyle(
                                    color: Colors.white), // Warna teks putih
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => const Text('Data tidak ditemukan'),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
