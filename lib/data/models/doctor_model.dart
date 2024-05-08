import 'package:konsuldoc/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel(
      {required super.id,
      required super.avatar,
      required super.email,
      required super.name,
      required super.specialist,
      required super.phone,
      required super.about,
      required super.createdAt,
      required super.updatedAt});
  
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      avatar: map['avatar'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      specialist: map['specialist'],
      about: map['about'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      
    );
  }
}
