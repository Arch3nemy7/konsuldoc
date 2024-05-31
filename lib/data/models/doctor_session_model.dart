import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';

class DoctorSessionModel extends DoctorSession {
  DoctorSessionModel({
    required super.quota,
    required super.timeStart,
    required super.timeEnd,
  });

  factory DoctorSessionModel.fromEntity(DoctorSession data) {
    return DoctorSessionModel(
      quota: data.quota,
      timeStart: data.timeStart,
      timeEnd: data.timeEnd,
    );
  }

  DoctorSession toEntity() {
    return DoctorSession(
      quota: quota,
      timeStart: timeStart,
      timeEnd: timeEnd,
    );
  }

  factory DoctorSessionModel.fromMap(Map<String, dynamic> map) {
    final timeStart = map['time_start'];
    final timeEnd = map['time_end'];

    return DoctorSessionModel(
      quota: map['quota'],
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
      'quota': quota,
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
