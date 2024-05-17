import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/repositories/appointment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_controller.g.dart';

@riverpod
AppointmentController appointmentController(AppointmentControllerRef ref) {
  return AppointmentController(repository: ref.watch(appointmentRepositoryProvider));
}

class AppointmentController {
  final AppointmentRepository _repository;

  AppointmentController({
    required AppointmentRepository repository,
  }) : _repository = repository;

  Future<bool> add(String idDoctor, DateTime date) async {
    final res = await handleError(_repository.add(
      idDoctor,
      date,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal menambahkan janji temu");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil menambahkan janji temu");
        return true;
      },
    );
  }

  Future<bool> editStatus(
    String id,
    AppointmentStatus status,
  ) async {
    final res = await handleError(_repository.editStatus(
      id,
      status,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal mengedit status");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil mengedit status");
        return true;
      },
    );
  }

  Future<bool> reschedule(
    String id,
    DateTime date,
  ) async {
    final res = await handleError(_repository.reschedule(
      id,
      date,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal mengedit jadwal janji temu");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil mengedit jadwal janji temu");
        return true;
      },
    );
  }
}
