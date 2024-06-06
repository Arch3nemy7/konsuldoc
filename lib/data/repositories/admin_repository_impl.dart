import 'dart:io';

import 'package:konsuldoc/core/constants/bucket_constants.dart';
import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/admin_model.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:konsuldoc/domain/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminRepositoryImpl implements AdminRepository {
  final SupabaseClient _supabase;
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;

  AdminRepositoryImpl({
    required SupabaseClient supabase,
    required AuthRepository authRepository,
    required StorageRepository storageRepository,
  })  : _supabase = supabase,
        _authRepository = authRepository,
        _storageRepository = storageRepository;

  @override
  Stream<List<AdminModel>> fetch() {
    return _supabase.from(TableConstants.admins).stream(primaryKey: ['id']).map(
      (event) => event.map(AdminModel.fromMap).toList(),
    );
  }

  @override
  Stream<AdminModel> fetchById(String id) {
    return _supabase
        .from(TableConstants.admins)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((event) => AdminModel.fromMap(event.first));
  }

  @override
  Future<void> add({
    File? avatar,
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final id = await _authRepository.addUser(
      email: email,
      password: password,
      role: Role.admin,
    );
    await _supabase.from(TableConstants.admins).insert({
      'id': id,
      'avatar': avatar == null
          ? null
          : await _storageRepository.uploadFile(
              file: avatar,
              bucket: BucketConstants.avatars,
              id: id,
            ),
      'email': email,
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> edit(
    String id, {
    File? avatar,
    required String email,
    required String name,
    String? phone,
  }) async {
    final data = {
      'email': email,
      'name': name,
      'phone': phone,
    };

    if (avatar != null) {
      await _storageRepository.deleteFile(BucketConstants.avatars, id);
      data['avatar'] = await _storageRepository.uploadFile(
        file: avatar,
        bucket: BucketConstants.avatars,
        id: id,
      );
    }

    await _supabase.from(TableConstants.admins).update(data).eq('id', id);
  }
}
