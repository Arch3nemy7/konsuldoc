import 'package:konsuldoc/data/models/change_payload_model.dart';
import 'package:konsuldoc/domain/entities/change_channel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeChannelModel<T> extends ChangeChannel<RealtimeChannel> {
  final T Function(Map<String, dynamic>) parser;

  ChangeChannelModel({
    required super.id,
    required super.channel,
    required this.parser,
    required PostgresChangeEvent event,
    String? schema,
    String? table,
    PostgresChangeFilter? filter,
  }) {
    channel.onPostgresChanges(
      event: event,
      schema: schema,
      table: table,
      filter: filter,
      callback: (payload) {
        final data = ChangePayloadModel.fromPayload(payload, parser);

        for (var listener in listeners) {
          listener(data);
        }
      },
    );
  }

  @override
  void dispose() {
    channel.unsubscribe();
  }
}
