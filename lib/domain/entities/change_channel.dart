import 'package:konsuldoc/domain/entities/change_payload.dart';

abstract class ChangeChannel<T> {
  final String id;
  final T channel;
  final List<void Function(ChangePayload)> listeners = [];

  ChangeChannel({required this.id, required this.channel});

  void addListener(void Function(ChangePayload) listener) {
    listeners.add(listener);
  }

  void removeListener(void Function(ChangePayload) listener) {
    listeners.remove(listener);
  }

  void dispose();

  @override
  bool operator ==(covariant ChangeChannel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
