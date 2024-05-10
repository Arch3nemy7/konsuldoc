import 'dart:io';

abstract interface class StorageRepository {
  Future<String> uploadFile({
    required File file,
    required String bucket,
    required String id,
  });
  void deleteFile(String bucket, String id);
}
