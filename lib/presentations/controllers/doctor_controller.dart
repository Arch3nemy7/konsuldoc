import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/entities/doctor.dart';
import 'package:konsuldoc/domain/entities/doctor_session.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/domain/repositories/doctor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doctor_controller.g.dart';

@riverpod
DoctorController doctorController(DoctorControllerRef ref) {
  return DoctorController(repository: ref.watch(doctorRepositoryProvider));
}

@riverpod
Stream<Doctor> fetchDoctorById(FetchDoctorByIdRef ref, String id) {
  return ref.watch(doctorRepositoryProvider).fetchById(id);
}

class DoctorController {
  final DoctorRepository _repository;

  DoctorController({
    required DoctorRepository repository,
  }) : _repository = repository;

  Future<bool> add({
    required File? avatar,
    required String name,
    required String email,
    required String password,
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  }) async {
    if (avatar == null) {
      BotToast.showText(text: "Foto profil wajib diisi");
      return false;
    }

    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
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
    cancel();

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
    required Specialist specialist,
    required String phone,
    required String about,
    required List<List<DoctorSession>> schedules,
  }) async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
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
    cancel();

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal mengedit data dokter");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil mengedit data dokter");
        return true;
      },
    );
  }
}
