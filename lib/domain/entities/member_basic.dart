import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class MemberBasic extends User {
  final String? avatar;
  final String name;

  MemberBasic({
    required super.id,
    required this.avatar,
    required this.name,
  }) : super(role: Role.member);
}
