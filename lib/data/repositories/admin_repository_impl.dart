import 'dart:io';

import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/admin_model.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminRepositoryImpl implements AdminRepository {
  final SupabaseClient _supabase;
  final AuthRepository _authRepository;

  AdminRepositoryImpl({
    required SupabaseClient supabase,
    required AuthRepository authRepository,
  })  : _supabase = supabase,
        _authRepository = authRepository;

  @override
  Future<List<AdminModel>> fetch(int page, int perPage) async {
    return (await _supabase.from(TableConstants.admins).select())
        .map((e) => AdminModel.fromMap(e))
        .toList();
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
      'email': email,
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> edit(
    String id, {
    String? avatar,
    required String email,
    required String name,
    String? phone,
  }) async {
    await _supabase.from(TableConstants.admins).update({
      'email': email,
      'name': name,
      'phone': phone,
    }).eq('id', id);
  }
}
