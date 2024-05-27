import 'package:konsuldoc/data/models/doctor_session_model.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.avatar,
    required super.email,
    required super.name,
    required super.specialist,
    required super.phone,
    required super.about,
    required super.schedules,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      avatar: map['avatar'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      specialist: Specialist.values.byName(map['specialist']),
      about: map['about'],
      schedules: (map['schedules'] as List)
          .map((e) =>
              (e as List).map((s) => DoctorSessionModel.fromMap(s)).toList())
          .toList(),
    );
  }
}
