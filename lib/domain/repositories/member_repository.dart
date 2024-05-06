import 'dart:io';

import 'package:konsuldoc/domain/entities/member.dart';

abstract interface class MemberRepository {
  Future<List<Member>> getMember();
  Future<Member> getMemberById(String id);
  Future<void> editMember(String id, File? avatar, String name, String email,
      String? phone, String? address, DateTime? dob, Gender? gender);
  Future<void> addMember(File? avatar, String name, String email, String? phone,
      String? address, DateTime? dob, Gender? gender);
}
