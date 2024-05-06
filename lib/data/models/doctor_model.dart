import 'package:konsuldoc/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({required super.id});

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(id: map['id']);
  }
}
