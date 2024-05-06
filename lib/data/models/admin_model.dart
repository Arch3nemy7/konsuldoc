import 'package:konsuldoc/domain/entities/admin.dart';

class AdminModel extends Admin {
  AdminModel({
    required super.id,
    required super.avatar,
    required super.email,
    required super.name,
    required super.phone,
  });

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'],
      avatar: map['avatar'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}
