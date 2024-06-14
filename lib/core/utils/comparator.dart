import 'package:flutter/material.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension DateTimeDayCompare on DateTime {
  bool isTimeAfter(TimeOfDay timeOfDay) {
    final dateToCompare = DateTime(
      year,
      month,
      day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return isAfter(dateToCompare);
  }
}
