import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/appointment_session.dart';
import 'package:konsuldoc/domain/enums/appointment_filter.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

abstract interface class AppointmentRepository {
  Future<List<AppointmentSession>> fetchBookedSession(String idDoctor);
  Future<List<Appointment>> fetch({
    String? memberId,
    DateTime? after,
    AppointmentFilter? filter,
    required int perPage,
  });
  Stream<Appointment> fetchById(String id);
  Future<void> add(
    String idDoctor,
    DateTime date,
    int session,
    String? complaints,
  );
  Future<void> editStatus(String id, {AppointmentStatus? status, String? note});
  Future<void> reschedule(String id, DateTime date, int session);
}
