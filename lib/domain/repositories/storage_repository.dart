import 'dart:io';

abstract interface class StorageRepository {
  Future<String> uploadFile({
    required File file,
    required String bucket,
    required String id,
  });
  Future<void> deleteFile(String bucket, String id);
}
