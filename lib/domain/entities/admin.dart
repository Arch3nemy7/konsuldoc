import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Admin extends User {
  Admin({required super.id}) : super(role: Role.admin);
}
