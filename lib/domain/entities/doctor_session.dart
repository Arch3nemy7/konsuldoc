import 'package:flutter/material.dart';

class DoctorSession {
  int quota;
  TimeOfDay timeStart;
  TimeOfDay timeEnd;

  DoctorSession({
    required this.quota,
    required this.timeStart,
    required this.timeEnd,
  });
}
