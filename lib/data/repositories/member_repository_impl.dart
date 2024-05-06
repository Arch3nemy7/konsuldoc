import 'dart:io';

import 'package:konsuldoc/constants/table_constants.dart';
import 'package:konsuldoc/data/models/member_model.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemberRepositoryImpl implements MemberRepository {
  final SupabaseClient _supabase;

  MemberRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<void> editMember(String id, File? avatar, String name, String email,
      String? phone, String? address, DateTime? dob, Gender? gender) async {
    await _supabase.from(TableConstants.member).update({
      'avatar': avatar,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'dob': dob,
      'gender': gender,
    }).match({'id': id});
  }

  @override
  Future<List<Member>> getMember() async {
    return (await _supabase.from(TableConstants.member).select())
        .map((e) => MemberModel.fromMap(e))
        .toList();
  }

  @override
  Future<Member> getMemberById(String id) async {
    return (await _supabase.from(TableConstants.member).select(id))
        .map((e) => MemberModel.fromMap(e))
        .first;
  }

  @override
  Future<void> addMember(File? avatar, String name, String email, String? phone,
      String? address, DateTime? dob, Gender? gender) async {
    await _supabase.from(TableConstants.member).insert({
      'avatar': avatar,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'dob': dob,
      'gender': gender,
    });
  }
}
