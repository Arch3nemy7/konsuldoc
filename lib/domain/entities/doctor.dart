import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/entities/user.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';

class Doctor extends User {
  final String? avatar;
  final String email;
  final String name;
  final Specialist specialist;
  final String phone;
  final String about;
  final List<List<DoctorSession>> schedules;

  Doctor({
    required super.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.specialist,
    required this.phone,
    required this.about,
    required this.schedules,
  }) : super(role: Role.doctor);

  get avatarUrl => null;
}
