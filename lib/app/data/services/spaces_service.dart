import 'package:Intellio/app/data/models/space_models/space_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class SpaceService {
  Logger log = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future createSpace(SpaceModel spaceModel) async {
    try {
      final String? uid = auth.currentUser?.uid;

      if (uid == null) {
        throw Exception('User not logged in');
      }

      final spaceRef = await _firestore
          .collection('spaces')
          .doc()
          .set(spaceModel.toJson());

      return true;
    } on FirebaseException catch (e) {
      log.e("Firebase error: ${e.message}");
      throw Exception('Firebase error: ${e.message}');
    } catch (e) {
      log.e("Unexpected error: ${e.toString()}");
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<List<SpaceModel>> getSpacesByUser(String uid) async {
    try {
      final querySnapshot = await _firestore.collection('spaces').get();

      return querySnapshot.docs.map((doc) {
        return SpaceModel.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    } on FirebaseException catch (e) {
      log.e("Firebase error: ${e.message}");
      throw Exception('Firebase error: ${e.message}');
    } catch (e) {
      log.e("Error fetching user spaces: $e");
      rethrow;
    }
  }
}
