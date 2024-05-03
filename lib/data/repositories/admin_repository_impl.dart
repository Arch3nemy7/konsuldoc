import 'package:konsuldoc/constants/table_constants.dart';
import 'package:konsuldoc/data/models/admin_model.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminRepositoryImpl implements AdminRepository {
  final SupabaseClient _supabase;

  AdminRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<AdminModel>> getAdmins() async {
    return (await _supabase.from(TableConstants.admin).select())
        .map((e) => AdminModel.fromJson(e))
        .toList();
  }

  @override
  Future<AdminModel> getAdminById(String id) async {
    return (await _supabase.from(TableConstants.admin).select(id))
        .map((e) => AdminModel.fromJson(e))
        .first;
  }

  @override
  Future<void> addAdmin(String id, String? avatar, String email, String name,
      String? phone) async {
    await _supabase.from(TableConstants.admin).insert({
      'avatar': avatar,
      'email': email,
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> updateAdmin(String id, String? avatar, String email, String name,
      String? phone) async {
    await _supabase.from(TableConstants.admin).update({
      'avatar': avatar,
      'email': email,
      'name': name,
      'phone': phone,
    }).match({'id': id});
  }

  @override
  Future<void> deleteAdmin(String id) async {
    await _supabase.from(TableConstants.admin).delete().match({'id': id});
  }
}
