import 'package:konsuldoc/data/models/doctor_basic_model.dart';
import 'package:konsuldoc/data/models/member_basic_model.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.id,
    required super.number,
    required super.member,
    required super.doctor,
    required super.date,
    required super.session,
    required super.complaints,
    required super.diagnosis,
    required super.status,
    required super.suggestions,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      number: map['number'],
      member: MemberBasicModel.fromMap(map['member']),
      doctor: DoctorBasicModel.fromMap(map['doctor']),
      date: DateTime.parse(map['date']),
      session: map['session'],
      complaints: map['complaints'],
      diagnosis: map['diagnosis'],
      status: AppointmentStatus.values[map['status']],
      suggestions: map['suggestion'],
    );
  }
}
