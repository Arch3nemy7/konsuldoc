import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/core/utils/show_loading.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_status.dart';
import 'package:konsuldoc/domain/repositories/appointment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_controller.g.dart';

@riverpod
AppointmentController appointmentController(AppointmentControllerRef ref) {
  return AppointmentController(
    repository: ref.watch(appointmentRepositoryProvider),
  );
}

@riverpod
Stream<Appointment> fetchAppointmentById(
  FetchAppointmentByIdRef ref,
  String id,
) {
  return ref.watch(appointmentRepositoryProvider).fetchById(id);
}

class AppointmentController {
  final AppointmentRepository _repository;

  AppointmentController({
    required AppointmentRepository repository,
  }) : _repository = repository;

  Future<bool> add(String idDoctor, DateTime date) async {
    final cancel = showLoading();
    final res = await handleError(_repository.add(idDoctor, date));
    cancel();

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
    String id, {
    AppointmentStatus? status,
    String? note,
  }) async {
    final cancel = showLoading();
    final res = await handleError(_repository.editStatus(
      id,
      status: status,
      note: note,
    ));
    cancel();

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
    final cancel = showLoading();
    final res = await handleError(_repository.reschedule(id, date));
    cancel();

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
