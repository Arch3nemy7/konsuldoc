import 'dart:io';

import 'package:konsuldoc/domain/entities/member.dart';

abstract interface class MemberRepository {
  Future<Member> fetchById(String id);
  Future<void> edit({
    required String id,
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  });
  Future<void> add({
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  });
}
