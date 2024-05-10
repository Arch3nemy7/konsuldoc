import 'dart:io';

import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/member_model.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemberRepositoryImpl implements MemberRepository {
  final SupabaseClient _supabase;

  MemberRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<Member> fetchById(String id) async {
    return (await _supabase.from(TableConstants.members).select(id))
        .map((e) => MemberModel.fromMap(e))
        .first;
  }

  @override
  Future<void> add({
    required String id,
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  }) async {
    await _supabase.from(TableConstants.members).insert({
      'id': id,
      'avatar': avatar,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'dob': dob,
      'gender': gender,
    });
  }

  @override
  Future<void> edit(
    String id, {
    File? avatar,
    required String name,
    required String email,
    String? phone,
    String? address,
    DateTime? dob,
    Gender? gender,
  }) async {
    await _supabase.from(TableConstants.members).update({
      'avatar': avatar,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'dob': dob,
      'gender': gender,
    }).match({'id': id});
  }
}
