import 'dart:io';

import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/gender.dart';

abstract interface class MemberRepository {
  Stream<Member> fetchById(String id);
  Future<void> add({
    required String id,
    required String name,
    required String email,
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
