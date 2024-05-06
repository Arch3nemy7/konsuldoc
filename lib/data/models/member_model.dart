import 'package:konsuldoc/domain/entities/member.dart';

class MemberModel extends Member {
  MemberModel({required super.id});

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(id: map['id']);
  }
}
