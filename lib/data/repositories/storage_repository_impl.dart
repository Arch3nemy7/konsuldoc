import 'dart:io';
import 'package:konsuldoc/domain/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepositoryImpl implements StorageRepository {
  final SupabaseClient _supabase;

  StorageRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<void> deleteFile(String bucket, String id) async {
    await _supabase.storage.from(bucket).remove([id]);
  }

  @override
  Future<String> uploadFile({
    required File file,
    required String bucket,
    required String id,
  }) async {
    final path = 'id/${DateTime.now().millisecondsSinceEpoch}';
    await _supabase.storage.from(bucket).upload(
          path,
          file,
          fileOptions: const FileOptions(upsert: true),
        );
    return _supabase.storage.from(bucket).getPublicUrl(path);
  }
}
