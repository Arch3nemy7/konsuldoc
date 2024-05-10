import 'dart:io';

import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/schedule.dart';

abstract interface class DoctorRepository {
  Future<List<Doctor>> fetch(int page, int perPage);
  Future<Doctor> fetchById(String id);
  Future<void> add({
    File? avatar,
    required String name,
    required String email,
    required String password,
    required String specialist,
    required String phone,
    required String about,
    required List<Schedule> schedules,
  });
  Future<void> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    required String specialist,
    required String phone,
    required String about,
    required List<Schedule> schedules,
  });
}
