import 'package:konsuldoc/domain/entities/member_basic.dart';

class MemberBasicModel extends MemberBasic {
  MemberBasicModel({
    required super.id,
    required super.avatar,
    required super.name,
  });

  factory MemberBasicModel.fromMap(Map<String, dynamic> map) {
    return MemberBasicModel(
      id: map['id'],
      avatar: map['avatar'],
      name: map['name'],
    );
  }
}
