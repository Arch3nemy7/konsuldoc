import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:konsuldoc/core/utils/pick_image.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/controllers/doctor_controller.dart';
import 'package:konsuldoc/presentations/widgets/pilih_sesi.dart';

class DoctorFormPage extends ConsumerStatefulWidget {
  final String id;
  const DoctorFormPage(this.id, {Key? key}) : super(key: key);

  @override
  ConsumerState<DoctorFormPage> createState() => _DoctorFormPageState();
}

class _DoctorFormPageState extends ConsumerState<DoctorFormPage> {
  File? avatarFile;
  Specialist? selectedSpecialist;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _specialistController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _showExpansion = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _specialistController.dispose();
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
  late final List<List<DoctorSession>> schedules =
      List.generate(weekdays.length, (index) => []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokter'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
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
                                  fit: BoxFit.cover,
                                  image: FileImage(avatarFile!))
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'https://cdn.pixabay.com/photo/2020/12/13/16/37/woman-5828786_1280.jpg',
                                  ),
                                ),
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
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 4, color: Colors.white),
                          color: Color.fromRGBO(28, 42, 58, 1),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.perm_identity_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return "Masukkan nama yang valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "No Telepon",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.add_call),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^\+?62[0-9]+$').hasMatch(value)) {
                    return "Masukkan nomor telepon yang valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              DropdownButtonFormField<Specialist>(
                decoration: const InputDecoration(
                  labelText: "Spesialis",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_services),
                ),
                value: selectedSpecialist,
                items: Specialist.values.map((Specialist specialist) {
                  return DropdownMenuItem<Specialist>(
                    value: specialist,
                    child: Text(specialist.label),
                  );
                }).toList(),
                onChanged: (Specialist? newValue) {
                  setState(() {
                    selectedSpecialist = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Masukkan spesialis";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Hari Kerja',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              Container(
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color:
                              selectedDay == index ? Colors.blue : Colors.white,
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
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: selectedDay == null
                    ? null
                    : () {
                        setState(() {
                          schedules[selectedDay!].add(DoctorSession(
                              quota: 0,
                              timeStart: TimeOfDay(hour: 0, minute: 0),
                              timeEnd: TimeOfDay(hour: 23, minute: 59)));
                        });
                      },
                child: Text('Tambah Sesi Dokter'),
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
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('Tambah'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(58, 115, 149, 1),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
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
    ref.read(doctorControllerProvider).add(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
          about: _aboutController.text,
          avatar: avatarFile,
          schedules: schedules,
          specialist: selectedSpecialist!,
        );
  }

  void updateDoctor() {
    ref.read(doctorControllerProvider).edit(widget.id,
        name: _nameController.text,
        email: _emailController.text,
        specialist: selectedSpecialist!,
        phone: _phoneController.text,
        about: _aboutController.text,
        schedules: schedules);
  }
}
