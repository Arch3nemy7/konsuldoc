import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Doctor extends User {
  final String? avatar;
  final String email;
  final String name;
  final String specialist;
  final String phone;
  final String about;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor(
      {required super.id,
      required this.avatar,
      required this.email,
      required this.name,
      required this.specialist,
      required this.phone,
      required this.about,
      required this.createdAt,
      required this.updatedAt})
      : super(role: Role.doctor);
}
