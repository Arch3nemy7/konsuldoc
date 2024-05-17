import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

enum Gender {
  male,
  female,
}

class Member extends User {
  final String? avatar;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final DateTime dob;
  final Gender? gender;
  final DateTime createdAt;

  Member({
    required super.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
    required this.gender,
    required this.createdAt,
  }) : super(role: Role.member);
}
