import 'package:konsuldoc/domain/entities/doctor_basic.dart';
import 'package:konsuldoc/domain/entities/member_basic.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

class Appointment {
  final String id;
  final int number;
  final MemberBasic member;
  final DoctorBasic doctor;
  final DateTime date;
  final int session;
  final String? complaints;
  final String? diagnosis;
  final AppointmentStatus status;
  final String? suggestions;

  Appointment({
    required this.id,
    required this.number,
    required this.member,
    required this.doctor,
    required this.date,
    required this.session,
    required this.complaints,
    required this.diagnosis,
    required this.status,
    required this.suggestions,
  });
}
