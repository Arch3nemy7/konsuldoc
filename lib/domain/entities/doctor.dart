import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';

class Doctor extends User {
  Doctor({required super.id}) : super(role: Role.doctor);
}
