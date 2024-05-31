import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Admin extends User {
  final String? avatar;
  final String email;
  final String name;
  final String? phone;

  Admin({
    required super.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone,
  }) : super(role: Role.admin);
}
