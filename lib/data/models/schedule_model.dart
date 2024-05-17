import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  ScheduleModel({
    required super.days,
    required super.timeStart,
    required super.timeEnd,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    final timeStart = map['time_start'];
    final timeEnd = map['time_end'];

    return ScheduleModel(
      days: List<int>.from(map['days']),
      timeStart: TimeOfDay(
        hour: timeStart['hour'],
        minute: timeStart['minute'],
      ),
      timeEnd: TimeOfDay(
        hour: timeEnd['hour'],
        minute: timeEnd['minute'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'days': days,
      'time_start': {
        'hour': timeStart.hour,
        'minute': timeStart.minute,
      },
      'time_end': {
        'hour': timeEnd.hour,
        'minute': timeEnd.minute,
      },
    };
  }
}
