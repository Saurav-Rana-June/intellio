import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageApi {
  static final _supabase = Supabase.instance.client;


  static final _profileBucket = _supabase.storage.from('user-profile-images');
  static final _feedBucket = _supabase.storage.from('feed-images');


  static Future<String?> uploadUserProfileImage(File file, String userId) async {
    try {
      final filePath = 'profile_$userId.jpg';
      await _profileBucket.upload(filePath, file, fileOptions: const FileOptions(upsert: true));
      return _profileBucket.getPublicUrl(filePath);
    } catch (e) {
      print('Failed to upload user profile image: $e');
      return null;
    }
  }


  static Future<String?> uploadFeedFile({
    required File file,
    required String postId,
    required String extension,
  }) async {
    try {
      final filePath = '$postId/${DateTime.now().millisecondsSinceEpoch}.$extension';
      await _feedBucket.upload(filePath, file);
      return _feedBucket.getPublicUrl(filePath);
    } catch (e) {
      print('Failed to upload feed file: $e');
      return null;
    }
  }

}
