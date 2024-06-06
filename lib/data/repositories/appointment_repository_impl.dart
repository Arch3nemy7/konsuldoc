import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/appointment_model.dart';
import 'package:konsuldoc/data/models/appointment_session_model.dart';
import 'package:konsuldoc/domain/entities/appointment_session.dart';
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
    String? doctorId,
    String? memberId,
    DateTime? date,
    int? session,
    AppointmentFilter? filter,
    int page = 1,
    required int perPage,
  }) async {
    var result = _supabase.from(TableConstants.appointments).select(
      '''
        id,
        member:id_member ( id, avatar, name ),
        doctor:id_doctor ( id, avatar, name, specialist ),
        date,
        status,
        session,
        number
      ''',
    );
    if (memberId != null) result = result.eq('id_member', memberId);
    if (doctorId != null) result = result.eq('id_doctor', doctorId);
    if (date != null) result = result.eq('date', date.toIso8601String());
    if (session != null) result = result.eq('session', session);

    if (filter == AppointmentFilter.upcoming) {
      result = result
          .gte('date', DateTime.now().toIso8601String())
          .eq('status', AppointmentStatus.waiting.index);
    } else if (filter == AppointmentFilter.past) {
      result = result
          .lte('date', DateTime.now().toIso8601String())
          .eq('status', AppointmentStatus.done.index);
    }

    return (await result
            .order('date', ascending: filter == AppointmentFilter.upcoming)
            .order('session')
            .order('number')
            .range((page - 1) * perPage, page * perPage - 1))
        .map(AppointmentModel.fromMap)
        .toList();
  }

  @override
  Stream<AppointmentModel> fetchById(String id) {
    return _supabase
        .from(TableConstants.appointments)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .asyncMap((event) async {
          final data = event.first;
          if (!membersCache.containsKey(data['id_member'])) {
            membersCache[data['id_member']] = await _supabase
                .from(TableConstants.members)
                .select('id, avatar, name')
                .eq('id', data['id_member'])
                .single();
          }
          if (!doctorsCache.containsKey(data['id_doctor'])) {
            doctorsCache[data['id_doctor']] = await _supabase
                .from(TableConstants.doctors)
                .select('id, avatar, name, specialist')
                .eq('id', data['id_doctor'])
                .single();
          }

          data['member'] = membersCache[data['id_member']];
          data['doctor'] = doctorsCache[data['id_doctor']];

          return AppointmentModel.fromMap(event.first);
        });
  }

  @override
  Future<String> add(
      String idDoctor, DateTime date, int session, String? complaints) async {
    final res = await _supabase
        .from(TableConstants.appointments)
        .insert({
          'id_member': _supabase.auth.currentUser!.id,
          'id_doctor': idDoctor,
          'date': date.toIso8601String(),
          'complaints': complaints?.isEmpty ?? true ? null : complaints,
          'session': session,
        })
        .select('id')
        .single();

    return res['id'];
  }

  @override
  Future<void> editStatus(
    String id, {
    AppointmentStatus? status,
    String? diagnosis,
    String? suggestion,
  }) async {
    if (status == null && diagnosis == null && suggestion == null) return;

    final data = {};
    if (status != null) data['status'] = status.index;
    if (diagnosis != null) data['diagnosis'] = diagnosis;
    if (suggestion != null) data['suggestion'] = suggestion;

    await _supabase.from(TableConstants.appointments).update(data).eq('id', id);
  }

  @override
  Future<void> reschedule(String id, DateTime date, int session) async {
    await _supabase.from(TableConstants.appointments).update({
      'date': date.toIso8601String(),
      'status': AppointmentStatus.waiting.index,
      'session': session
    }).eq('id', id);
  }

  @override
  Future<List<AppointmentSession>> fetchBookedSession(
      String idDoctor, String idMember) async {
    final List<Map<String, dynamic>> res = await _supabase.rpc(
      'get_fully_booked_appointments',
      params: {
        'p_id_doctor': idDoctor,
        'p_id_member': idMember,
        'after_date': DateTime.now().toIso8601String()
      },
    );
    return res.map((e) => AppointmentSessionModel.fromMap(e)).toList();
  }
}
