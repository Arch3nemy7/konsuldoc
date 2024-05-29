import 'package:konsuldoc/core/utils/comparator.dart';

class AppointmentSession {
  final DateTime date;
  final int session;

  AppointmentSession({required this.date, required this.session});

  @override
  bool operator ==(covariant AppointmentSession other) {
    if (identical(this, other)) return true;

    return other.date.isSameDate(date) && other.session == session;
  }

  @override
  int get hashCode => date.hashCode ^ session.hashCode;

  @override
  String toString() => 'AppointmentSession(date: $date, session: $session)';
}
