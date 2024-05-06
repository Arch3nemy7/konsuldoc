import 'package:konsuldoc/domain/entities/admin.dart';

class AdminModel extends Admin {
  AdminModel({required super.id});

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(id: map['id']);
  }
}
