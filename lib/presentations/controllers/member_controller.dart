import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/gender.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_controller.g.dart';

@riverpod
MemberController memberController(MemberControllerRef ref) {
  return MemberController(repository: ref.watch(memberRepositoryProvider));
}

@riverpod
Stream<Member> fetchMemberById(FetchMemberByIdRef ref, String id) {
  return ref.watch(memberRepositoryProvider).fetchById(id);
}

class MemberController {
  final MemberRepository _repository;

  MemberController({
    required MemberRepository repository,
  }) : _repository = repository;

  Future<bool> add({
    required String id,
    required String name,
    required String email,
  }) async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.add(
      id: id,
      name: name,
      email: email,
    ));
    cancel();

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
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
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
    cancel();

    return res.fold(
      (l) {
        BotToast.showText(text: "Gagal mengedit data member");
        return false;
      },
      (r) {
        BotToast.showText(text: "Berhasil mengedit data member");
        return true;
      },
    );
  }
}
