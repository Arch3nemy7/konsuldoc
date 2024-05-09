import 'dart:io';

abstract interface class StorageRepository {
  Future<String> uploadFile(File file, String bucket, String id);

  void deleteFile(String bucket, String id);
}