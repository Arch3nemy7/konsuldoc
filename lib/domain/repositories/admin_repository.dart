import 'package:konsuldoc/domain/entities/admin.dart';

abstract interface class AdminRepository {
  Future<List<Admin>> getAdmins();

  Future<Admin> getAdminById(String id);

  Future<void> addAdmin(
      String id, String? avatar, String email, String name, String? phone);

  Future<void> updateAdmin(
      String id, String? avatar, String email, String name, String? phone);

  Future<void> deleteAdmin(String id);
}
