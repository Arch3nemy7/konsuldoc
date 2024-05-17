import 'package:intl/intl.dart';

final timeFormatter = DateFormat('H:mm');
final dateFormatter = DateFormat('MMMM d, y');
final shortDateFormatter = DateFormat('M/d/y');

extension TimeFormatter on DateTime {
  String toTimeString() => timeFormatter.format(this);
  String toDateString() => dateFormatter.format(this);
  String toShortDateString() => shortDateFormatter.format(this);
}
