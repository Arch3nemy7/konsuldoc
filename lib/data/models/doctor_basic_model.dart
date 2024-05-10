import 'package:konsuldoc/domain/entities/doctor_basic.dart';

class DoctorBasicModel extends DoctorBasic {
  DoctorBasicModel({
    required super.id,
    required super.avatar,
    required super.name,
    required super.specialist,
  });

  factory DoctorBasicModel.fromMap(Map<String, dynamic> map) {
    return DoctorBasicModel(
      id: map['id'],
      avatar: map['avatar'],
      name: map['name'],
      specialist: map['specialist'],
    );
  }
}
