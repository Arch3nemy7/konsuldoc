import 'dart:io';

import 'package:konsuldoc/core/constants/bucket_constants.dart';
import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/data/models/member_model.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/gender.dart';
import 'package:konsuldoc/domain/repositories/member_repository.dart';
import 'package:konsuldoc/domain/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemberRepositoryImpl implements MemberRepository {
  final SupabaseClient _supabase;
  final StorageRepository _storageRepository;

  MemberRepositoryImpl({
    required SupabaseClient supabase,
    required StorageRepository storageRepository,
  })  : _supabase = supabase,
        _storageRepository = storageRepository;

  @override
  Stream<Member> fetchById(String id) {
    return _supabase
        .from(TableConstants.members)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((event) => MemberModel.fromMap(event.first));
  }

  @override
  Future<void> add({
    required String id,
    required String name,
    required String email,
  }) async {
    await _supabase.from(TableConstants.members).insert({
      'id': id,
      'name': name,
      'email': email,
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
    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'dob': dob?.toIso8601String(),
      'gender': gender?.name,
    };

    if (avatar != null) {
      await _storageRepository.deleteFile(BucketConstants.avatars, id);
      data['avatar'] = await _storageRepository.uploadFile(
        file: avatar,
        bucket: BucketConstants.avatars,
        id: id,
      );
    }

    await _supabase.from(TableConstants.members).update(data).match({'id': id});
  }
}
