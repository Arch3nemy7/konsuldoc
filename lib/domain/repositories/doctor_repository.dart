import 'dart:io';

import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';

abstract interface class DoctorRepository {
  Future<List<Doctor>> fetch(int page, int perPage);
  Stream<Doctor> fetchById(String id);
  Future<void> add({
    required File avatar,
    required String name,
    required String email,
    required String password,
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  });
  Future<void> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  });
}

class Schedule {}
