import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Member extends User {
  Member({required super.id}) : super(role: Role.member);
}
