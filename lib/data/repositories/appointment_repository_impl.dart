import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/appointment_model.dart';
import 'package:konsuldoc/data/models/change_channel_model.dart';
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
  ChangeChannelModel getChannel({
    String? idMember,
    AppointmentStatus? status,
    bool upcomingOnly = false,
  }) {
    final id = 'appointment:${idMember ?? 'all'}';

    return ChangeChannelModel(
      id: id,
      channel: _supabase.channel(id),
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: TableConstants.appointments,
      filter: idMember == null
          ? null
          : PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id_member',
              value: idMember,
            ),
      parser: (payload) async {
        if (!membersCache.keys.contains(payload['id_member'])) {
          membersCache[payload['id_member']] = await _supabase
              .from(TableConstants.members)
              .select('id, avatar, name')
              .eq('id', payload['id_member'])
              .single();
        }
        if (!doctorsCache.keys.contains(payload['id_doctor'])) {
          doctorsCache[payload['id_doctor']] = await _supabase
              .from(TableConstants.doctors)
              .select('id, avatar, name, specialist ')
              .eq('id', payload['id_doctor'])
              .single();
        }

        if (membersCache.keys.length > 100) {
          membersCache.remove(membersCache.keys.first);
        }
        if (doctorsCache.keys.length > 100) {
          doctorsCache.remove(doctorsCache.keys.first);
        }

        payload['member'] = membersCache[payload['id_member']];
        payload['doctor'] = doctorsCache[payload['id_doctor']];

        return AppointmentModel.fromMap(payload);
      },
    );
  }

  @override
  Future<List<AppointmentModel>> fetch({
    String? memberId,
    required DateTime? after,
    required int perPage,
    AppointmentStatus? status,
    bool upcomingOnly = false,
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
  Future<void> add(String idDoctor, DateTime date, int session, String? complaints)async {
    await _supabase.from(TableConstants.appointments).insert({
      'id_member': _supabase.auth.currentUser!.id,
      'id_doctor': idDoctor,
      'date': date.toIso8601String(),
      'complaints': complaints,
      'session': session,
    });
  }

  @override
  Future<void> editStatus(String id, AppointmentStatus status) async {
    await _supabase
        .from(TableConstants.appointments)
        .update({'status': status.index}).eq('id', id);
  }

  @override
  Future<void> reschedule(String id, DateTime date, int session) async {
    await _supabase.from(TableConstants.appointments).update({
      'date': date.toIso8601String(),
      'status': AppointmentStatus.pending.index,
      'session': session
    }).eq('id', id);
  }
}
