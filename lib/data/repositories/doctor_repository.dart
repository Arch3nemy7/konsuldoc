import 'dart:io';

import 'package:konsuldoc/domain/entities/doctor.dart';

abstract interface class DoctorRepository {
  List<Doctor> fetch(int page, int per_page);
  Doctor fetchById(String id);
  void add(File? avatar,String name, String email, String specialist,String phone, String about, List<Schedule> schedules);
  void edit(String id,File? avatar,String name, String email, String specialist,String phone, String about, List<Schedule> schedules);
  
}