import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';

class MemberController {
  final MemberRepository _repository;

  MemberController({
    required MemberRepository repository,
  }) : _repository = repository;

  Future<bool> add({
    required String id,
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  }) async {
    final res = await handleError(_repository.add(
      id: id,
      avatar: avatar,
      name: name,
      email: email,
      phone: phone,
      address: address,
      dob: dob,
      gender: gender,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal menambahkan member");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil menambahkan member");
        return true;
      },
    );
  }

  Future<bool> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  }) async {
    final res = await handleError(_repository.edit(
      id,
      avatar: avatar,
      name: name,
      email: email,
      phone: phone,
      address: address,
      dob: dob,
      gender: gender,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal meng-edit member");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil meng-edit member");
        return true;
      },
    );
  }
}
