import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/gender.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Member extends User {
  final String? avatar;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final DateTime dob;
  final Gender? gender;

  Member({
    required super.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
    required this.gender,
  }) : super(role: Role.member);
}
