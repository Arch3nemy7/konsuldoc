import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';

class DoctorBasic extends User {
  final String? avatar;
  final String name;
  final Specialist specialist;

  DoctorBasic({
    required super.id,
    required this.avatar,
    required this.name,
    required this.specialist,
  }) : super(role: Role.doctor);
}
