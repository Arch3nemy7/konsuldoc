import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/entities/schedule.dart';
import 'package:konsuldoc/domain/repositories/doctor_repository.dart';

class DoctorController {
  final DoctorRepository _repository;

  DoctorController({
    required DoctorRepository repository,
  }) : _repository = repository;

  Future<bool> add({
    File? avatar,
    required String name,
    required String email,
    required String password,
    required String specialist,
    required String phone,
    required String about,
    required List<Schedule> schedules,
  }) async {
    final res = await handleError(_repository.add(
      avatar: avatar,
      name: name,
      email: email,
      password: password,
      specialist: specialist,
      phone: phone,
      about: about,
      schedules: schedules,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal menambahkan dokter");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil menambahkan dokter");
        return true;
      },
    );
  }

  Future<bool> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    required String specialist,
    required String phone,
    required String about,
    required List<Schedule> schedules,
  }) async {
    final res = await handleError(_repository.edit(
      id,
      avatar: avatar,
      name: name,
      email: email,
      specialist: specialist,
      phone: phone,
      about: about,
      schedules: schedules,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal meng-edit dokter");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil meng-edit dokter");
        return true;
      },
    );
  }
}
