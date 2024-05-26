import 'dart:io';

import 'package:konsuldoc/core/constants/bucket_constants.dart';
import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/doctor_model.dart';
import 'package:konsuldoc/data/models/doctor_session_model.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/domain/repositories/doctor_repository.dart';
import 'package:konsuldoc/domain/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final SupabaseClient _supabase;
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;

  DoctorRepositoryImpl({
    required SupabaseClient supabase,
    required AuthRepository authRepository,
    required StorageRepository storageRepository,
  })  : _supabase = supabase,
        _authRepository = authRepository,
        _storageRepository = storageRepository;

  @override
  Future<List<Doctor>> fetch(int page, int perPage) async {
    return (await _supabase.from(TableConstants.doctors).select())
        .map((e) => DoctorModel.fromMap(e))
        .toList();
  }

  @override
  Stream<Doctor> fetchById(String id) {
    return _supabase
        .from(TableConstants.doctors)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((event) => DoctorModel.fromMap(event.first));
  }

  @override
  Future<void> add({
    required File avatar,
    required String name,
    required String email,
    required String password,
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  }) async {
    final id = await _authRepository.addUser(
      email: email,
      password: password,
      role: Role.doctor,
    );
    await _supabase.from(TableConstants.doctors).insert({
      'id': id,
      'avatar': await _storageRepository.uploadFile(
        file: avatar,
        bucket: BucketConstants.avatars,
        id: id,
      ),
      'name': name,
      'email': email,
      'specialist': specialist.name,
      'phone': phone,
      'about': about,
      'schedules': List<List<DoctorSessionModel>>.from(schedules)
          .map((e) => e.map((s) => s.toMap())),
    });
  }

  @override
  Future<void> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'specialist': specialist.name,
      'phone': phone,
      'about': about,
      'schedules': List<List<DoctorSessionModel>>.from(schedules)
          .map((e) => e.map((s) => s.toMap())),
    };

    if (avatar != null) {
      data['avatar'] = await _storageRepository.uploadFile(
        file: avatar,
        bucket: BucketConstants.avatars,
        id: id,
      );
    }
    await _supabase.from(TableConstants.doctors).update(data).eq('id', id);
  }
}
