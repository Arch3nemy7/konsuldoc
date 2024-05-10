import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/entities/member_basic.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

class Appointment {
  final String id;
  final MemberBasic member;
  final DoctorBasic doctor;
  final DateTime date;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.member,
    required this.doctor,
    required this.date,
    required this.status,
  });
}
