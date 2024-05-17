import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/gender.dart';

class MemberModel extends Member {
  MemberModel({
    required super.id,
    required super.avatar,
    required super.email,
    required super.name,
    required super.phone,
    required super.address,
    required super.dob,
    required super.gender,
  });

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'],
      avatar: map['avatar'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      dob: map['dob'],
      gender: Gender.values.byName(map['gender']),
    );
  }
}
