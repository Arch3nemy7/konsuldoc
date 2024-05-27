import 'package:konsuldoc/domain/enums/change_type.dart';

class ChangePayload<T> {
  final ChangeType type;
  final String oldId;
  final T data;

  ChangePayload({required this.type, required this.oldId, required this.data});
}
