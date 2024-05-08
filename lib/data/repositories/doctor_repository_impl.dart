import 'dart:io';

import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/doctor_model.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/schedule.dart';
import 'package:konsuldoc/domain/repositories/doctor_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final SupabaseClient _supabase;

  DoctorRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<Doctor>> fetch(int page, int perPage) async {
    return (await _supabase.from(TableConstants.doctors).select())
        .map((e) => DoctorModel.fromMap(e))
        .toList();
  }

  @override
  Future<Doctor> fetchById(String id) async {
    return DoctorModel.fromMap(
      (await _supabase.from(TableConstants.doctors).select().eq('id', id))
          .first,
    );
  }

  @override
  Future<void> add(
    File? avatar,
    String name,
    String email,
    String specialist,
    String phone,
    String about,
    List<Schedule> schedules,
  ) async {
    await _supabase.from(TableConstants.doctors).insert({
      "name": name,
      "email": email,
      "specialist": specialist,
      "phone": phone,
      "about": about,
      "schedules": schedules,
    });
  }

  @override
  Future<void> edit(
    String id,
    File? avatar,
    String name,
    String email,
    String specialist,
    String phone,
    String about,
    List<Schedule> schedules,
  ) async {
    await _supabase.from(TableConstants.doctors).update({
      "name": name,
      "email": email,
      "specialist": specialist,
      "phone": phone,
      "about": about,
      "schedules": schedules,
    }).eq('id', id);
  }
}
