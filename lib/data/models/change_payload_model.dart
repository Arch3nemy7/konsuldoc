import 'package:konsuldoc/domain/entities/change_payload.dart';
import 'package:konsuldoc/domain/enums/change_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePayloadModel<T> extends ChangePayload<T> {
  ChangePayloadModel({
    required super.type,
    required super.oldId,
    required super.data,
  });

  factory ChangePayloadModel.fromPayload(
    PostgresChangePayload payload,
    T Function(Map<String, dynamic>) parser,
  ) {
    return ChangePayloadModel(
      type: switch (payload.eventType) {
        PostgresChangeEvent.all => throw UnimplementedError(),
        PostgresChangeEvent.delete => ChangeType.delete,
        PostgresChangeEvent.insert => ChangeType.insert,
        PostgresChangeEvent.update => ChangeType.update,
      },
      oldId: payload.oldRecord['id'],
      data: parser(payload.newRecord),
    );
  }
}
