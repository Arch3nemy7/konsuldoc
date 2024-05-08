import 'dart:io';

import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/schedule.dart';

abstract interface class DoctorRepository {
  Future<List<Doctor>> fetch(int page, int perPage);
  Future<Doctor> fetchById(String id);
  Future<void> add(File? avatar, String name, String email, String specialist,
      String phone, String about, List<Schedule> schedules);
  Future<void> edit(String id, File? avatar, String name, String email,
      String specialist, String phone, String about, List<Schedule> schedules);
}
