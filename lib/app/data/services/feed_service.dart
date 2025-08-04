import 'dart:io';

import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedService {
  static final _feedsCollection = FirebaseFirestore.instance.collection(
    'feeds',
  );
  static final _supabase = Supabase.instance.client;
  static final _feedBucket = _supabase.storage.from('feed-bucket');

  // Saving Feed Files to Supabase
  static Future<String?> uploadFeedFile({
    required File file,
    required String postId,
    required String extension,
  }) async {
    try {
      final filePath =
          '$postId/${DateTime.now().millisecondsSinceEpoch}.$extension';
      await _feedBucket.upload(filePath, file);
      return _feedBucket.getPublicUrl(filePath);
    } catch (e) {
      print('Failed to upload feed file: $e');
      return null;
    }
  }

  static Future<bool> addFeed(FeedTileModel model) async {
    try {
      await _feedsCollection.add(model.toMap());
      return true;
    } catch (e) {
      throw Exception("Failed to add feed: $e");
    }
  }

  static Future<List<FeedTileModel>> fetchFeeds() async {
    try {
      final snapshot =
          await _feedsCollection.orderBy('postedTime', descending: true).get();
      return snapshot.docs
          .map((doc) => FeedTileModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch feeds: $e');
    }
  }
}
