import 'package:konsuldoc/domain/entities/appointment_session.dart';

class AppointmentSessionModel extends AppointmentSession {
  AppointmentSessionModel({required super.date, required super.session});

  factory AppointmentSessionModel.fromMap(Map<String, dynamic> map) {
    return AppointmentSessionModel(
      date: DateTime.parse(map['date']),
      session: map['session'],
    );
  }
}
