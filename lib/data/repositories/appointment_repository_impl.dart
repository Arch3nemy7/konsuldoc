import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/appointment_model.dart';
import 'package:konsuldoc/domain/enums/appointment_filter.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/repositories/appointment_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final SupabaseClient _supabase;
  final membersCache = <String, Map>{};
  final doctorsCache = <String, Map>{};

  AppointmentRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<AppointmentModel>> fetch({
    String? memberId,
    AppointmentFilter? filter,
    DateTime? after,
    required int perPage,
  }) async {
    var result = _supabase.from(TableConstants.appointments).select(
      '''
        id,
        member:id_member ( id, avatar, name ),
        doctor:id_doctor ( id, avatar, name, specialist ),
        date,
        status
      ''',
    );
    if (memberId != null) result = result.eq('id_member', memberId);
    if (after != null) result = result.gt('date', after.toIso8601String());
    return (await result.order('date').limit(perPage))
        .map(AppointmentModel.fromMap)
        .toList();
  }

  @override
  Stream<AppointmentModel> fetchById(String id) {
    return _supabase
        .from(TableConstants.appointments)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((event) => AppointmentModel.fromMap(event.first));
  }

  @override
  Future<void> add(String idDoctor, DateTime date) async {
    await _supabase.from(TableConstants.appointments).insert({
      'id_member': _supabase.auth.currentUser!.id,
      'id_doctor': idDoctor,
      'date': date.toIso8601String(),
    });
  }

  @override
  Future<void> editStatus(
    String id, {
    AppointmentStatus? status,
    String? note,
  }) async {
    if (status == null && note == null) return;

    final data = {};
    if (status != null) data['status'] = status.index;
    if (note != null) data['note'] = note;

    await _supabase.from(TableConstants.appointments).update(data).eq('id', id);
  }

  @override
  Future<void> reschedule(String id, DateTime date) async {
    await _supabase.from(TableConstants.appointments).update({
      'date': date.toIso8601String(),
      'status': AppointmentStatus.waiting.index,
    }).eq('id', id);
  }
}
