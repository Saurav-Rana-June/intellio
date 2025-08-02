import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/feed_models/feed_model.dart';

class FirestoreApi {
  static final _feedsCollection = FirebaseFirestore.instance.collection('feeds');

  static Future<void> addFeed(FeedTileModel model) async {
    try {
      await _feedsCollection.add(model.toMap());
    } catch (e) {
      throw Exception("Failed to add feed: $e");
    }
  }


  static Future<List<FeedTileModel>> fetchFeeds() async {
    try {
      final snapshot = await _feedsCollection.orderBy('postedTime', descending: true).get();
      return snapshot.docs
          .map((doc) => FeedTileModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch feeds: $e');
    }
  }


}