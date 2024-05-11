import 'dart:io';

import 'package:konsuldoc/domain/entities/member.dart';

abstract interface class MemberRepository {
  Stream<Member> fetchById(String id);
  Future<void> add({
    required String id,
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  });
  Future<void> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  });
}
