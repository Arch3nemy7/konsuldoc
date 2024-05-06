import 'dart:io';

enum Gender {
  male,
  female,
}

class Member {
  final String id;
  final File? avatar;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final DateTime dob;
  final Gender? gender;
  final DateTime createdAt;

  Member({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
    required this.gender,
    required this.createdAt,
  });
}
