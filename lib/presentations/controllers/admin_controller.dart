import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';

class AdminController {
  final AdminRepository _repository;

  AdminController({
    required AdminRepository repository,
  }) : _repository = repository;

  Future<bool> add({
    File? avatar,
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final res = await handleError(_repository.add(
      email: email,
      password: password,
      name: name,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal menambahkan admin");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil menambahkan admin");
        return true;
      },
    );
  }

  Future<bool> edit(
    String id, {
    String? avatar,
    required String email,
    required String name,
    String? phone,
  }) async {
    final res = await handleError(_repository.edit(
      id,
      email: email,
      name: name,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal mengedit data admin");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil mengedit data admin");
        return true;
      },
    );
  }
}
