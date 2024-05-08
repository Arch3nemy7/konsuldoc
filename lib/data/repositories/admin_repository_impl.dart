import 'dart:io';

import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/admin_model.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminRepositoryImpl implements AdminRepository {
  final SupabaseClient _supabase;

  AdminRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<AdminModel>> fetch(int page, int perPage) async {
    return (await _supabase.from(TableConstants.admins).select())
        .map((e) => AdminModel.fromMap(e))
        .toList();
  }

  @override
  Future<AdminModel> fetchById(String id) async {
    return AdminModel.fromMap(
      (await _supabase.from(TableConstants.admins).select().eq('id', id)).first,
    );
  }

  @override
  Future<void> add({
    File? avatar,
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    await _supabase.from(TableConstants.admins).insert({
      'email': email,
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> edit({
    required String id,
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
