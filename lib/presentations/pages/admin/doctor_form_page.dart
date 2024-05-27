import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:konsuldoc/core/utils/pick_image.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/pilih_sesi.dart';

@RoutePage()
class DoctorFormPage extends ConsumerStatefulWidget {
  final Doctor? doctor;
  const DoctorFormPage({super.key, this.doctor});

  @override
  ConsumerState<DoctorFormPage> createState() => _DoctorFormPageState();
}

class _DoctorFormPageState extends ConsumerState<DoctorFormPage> {
  Doctor? get doctor => widget.doctor;

  File? avatarFile;
  late Specialist? selectedSpecialist = doctor?.specialist;
  late final _nameController = TextEditingController(text: doctor?.name);
  late final _aboutController = TextEditingController(text: doctor?.about);
  late final _emailController = TextEditingController(text: doctor?.email);
  late final _passwordController = TextEditingController();
  late final _phoneController = TextEditingController(text: doctor?.phone);

  bool obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        avatarFile = File(res.files.first.path!);
      });
    }
  }

  int? selectedDay;
  final List<String> weekdays = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  late final schedules = List<List<DoctorSession>>.from(
      doctor?.schedules ?? List.generate(weekdays.length, (index) => []));

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokter'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: const AutoLeadingButton(),
        actions: [
          if (doctor != null)
            IconButton(
              onPressed: () {
                ref
                    .read(authControllerProvider)
                    .deleteUser(doctor!.id)
                    .then((value) {
                  if (value) context.maybePop();
                });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: selectBannerImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: avatarFile != null
                          ? DecorationImage(
                              fit: BoxFit.cover, image: FileImage(avatarFile!))
                          : widget.doctor?.avatar != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.doctor!.avatar!,
                                  ),
                                )
                              : null,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 4, color: Colors.white),
                      color: const Color.fromRGBO(28, 42, 58, 1),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.perm_identity_rounded),
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                return "Masukkan nama yang valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                return "Masukkan email yang valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          if (doctor == null)
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscurePassword,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return "Password harus memiliki setidaknya 6 karakter";
                }
                return null;
              },
            ),
          if (doctor == null) const SizedBox(height: 15),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "No Telepon",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.add_call),
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^\+?62[0-9]+$').hasMatch(value)) {
                return "Masukkan nomor telepon yang valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _aboutController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: "About",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Masukkan About";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          DropdownMenu(
            label: const Text('Spesialis'),
            width: mediaQuery.size.width - 30,
            initialSelection: selectedSpecialist,
            leadingIcon: selectedSpecialist == null
                ? null
                : Icon(selectedSpecialist!.icon),
            onSelected: (value) {
              setState(() {
                selectedSpecialist = value;
              });
            },
            dropdownMenuEntries: Specialist.values
                .map((e) => DropdownMenuEntry(
                    value: e, label: e.label, leadingIcon: Icon(e.icon)))
                .toList(),
          ),
          const SizedBox(height: 15),
          const Text(
            'Hari Kerja',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekdays.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = index;
                    });
                  },
                  child: Container(
                    width: 85,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedDay == index ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        weekdays[index],
                        style: TextStyle(
                          color: selectedDay == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: selectedDay == null
                ? null
                : () {
                    setState(() {
                      schedules[selectedDay!].add(DoctorSession(
                          quota: 0,
                          timeStart: const TimeOfDay(hour: 0, minute: 0),
                          timeEnd: const TimeOfDay(hour: 23, minute: 59)));
                    });
                  },
            child: const Text('Tambah Sesi Dokter'),
          ),
          ...(selectedDay == null
              ? []
              : schedules[selectedDay!].mapWithIndex(
                  (session, index) => PilihSesi(
                    title: "Sesi ${index + 1}",
                    onUpdate: refresh,
                    session: schedules[selectedDay!][index],
                    onDelete: () => deleteSession(selectedDay!, index),
                  ),
                )),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (widget.doctor == null) {
                  insertDoctor();
                } else {
                  updateDoctor();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(58, 115, 149, 1),
                foregroundColor: Colors.white,
              ),
              child: Text(widget.doctor == null ? 'Tambah' : 'Simpan'),
            ),
          ),
        ],
      ),
    );
  }

  void deleteSession(int day, int index) {
    setState(() {
      schedules[day].removeAt(index);
    });
  }

  void refresh() {
    setState(() {});
  }

  void insertDoctor() {
    ref
        .read(doctorControllerProvider)
        .add(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
          about: _aboutController.text,
          avatar: avatarFile,
          schedules: schedules,
          specialist: selectedSpecialist!,
        )
        .then((value) {
      if (value) context.maybePop();
    });
  }

  void updateDoctor() {
    ref
        .read(doctorControllerProvider)
        .edit(widget.doctor!.id,
            name: _nameController.text,
            email: _emailController.text,
            specialist: selectedSpecialist!,
            phone: _phoneController.text,
            about: _aboutController.text,
            schedules: schedules)
        .then((value) {
      if (value) context.maybePop();
    });
  }
}
