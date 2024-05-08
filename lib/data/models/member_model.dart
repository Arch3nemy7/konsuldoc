import 'package:konsuldoc/domain/entities/member.dart';

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
    required super.createdAt,
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
        gender: map['map'],
        createdAt: map['createdAt']);
  }
}
