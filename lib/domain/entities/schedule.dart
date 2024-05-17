import 'package:flutter/material.dart';

class Schedule {
  final List<int> days;
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;

  Schedule({
    required this.days,
    required this.timeStart,
    required this.timeEnd,
  });
}
