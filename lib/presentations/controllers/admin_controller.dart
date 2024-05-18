import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/entities/admin.dart';
import 'package:konsuldoc/domain/repositories/admin_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_controller.g.dart';

@riverpod
AdminController adminController(AdminControllerRef ref) {
  return AdminController(repository: ref.watch(adminRepositoryProvider));
}

@riverpod
Stream<Admin> fetchAdminById(FetchAdminByIdRef ref, String id) {
  return ref.watch(adminRepositoryProvider).fetchById(id);
}

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
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.add(
      avatar: avatar,
      email: email,
      password: password,
      name: name,
    ));
    cancel();

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
    File? avatar,
    required String email,
    required String name,
    String? phone,
  }) async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.edit(
      id,
      avatar: avatar,
      email: email,
      name: name,
    ));
    cancel();

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
