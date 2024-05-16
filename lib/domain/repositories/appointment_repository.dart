import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/entities/change_channel.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';

abstract interface class AppointmentRepository {
  ChangeChannel getChannel({
    String? idMember,
    AppointmentStatus? status,
    bool upcomingOnly = false,
  });
  Future<List<Appointment>> fetch({
    String? memberId,
    required DateTime after,
    required int perPage,
    AppointmentStatus? status,
    bool upcomingOnly = false,
  });
  Stream<Appointment> fetchById(String id);
  Future<void> add(String idDoctor, DateTime date);
  Future<void> editStatus(String id, AppointmentStatus status);
  Future<void> reschedule(String id, DateTime date);
}
