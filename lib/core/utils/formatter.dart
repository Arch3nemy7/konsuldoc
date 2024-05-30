import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final timeFormatter = DateFormat('H:mm');
final dateFormatter = DateFormat('EEEE, d MMMM y');
final dayFormatter = DateFormat('EEEE');
final shortDayFormatter = DateFormat('E');
final shortDateFormatter = DateFormat('M/d/y');

extension TimeOfDayFormatter on TimeOfDay {
  String toTimeString() =>
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}

extension TimeFormatter on DateTime {
  String toTimeString() => timeFormatter.format(this);
  String toDateString() => dateFormatter.format(this);
  String toDayString() => dayFormatter.format(this);
  String toShortDayString() => shortDayFormatter.format(this);
  String toShortDateString() => shortDateFormatter.format(this);
}
