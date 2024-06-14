import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/appointment_session.dart';
import 'package:konsuldoc/domain/enums/appointment_filter.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

abstract interface class AppointmentRepository {
  Future<List<AppointmentSession>> fetchBookedSession(
    String idDoctor,
    String idMember,
  );
  Future<List<Appointment>> fetch({
    String? doctorId,
    String? memberId,
    DateTime? date,
    int? session,
    AppointmentFilter? filter,
    bool? ascending,
    int page,
    required int perPage,
  });
  Stream<Appointment> fetchById(String id);
  Future<String> add(
    String idDoctor,
    DateTime date,
    int session,
    String? complaints,
  );
  Future<void> editStatus(String id,
      {AppointmentStatus? status, String? diagnosis, String? suggestion});
  Future<void> cancel(String id);
  Future<void> reschedule(String id, DateTime date, int session);
}
