import 'dart:math';

import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  Logger log = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login Method
  Future<UserModel?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;

      if (user != null) {
        final userModal = getUserByUid(user.uid);
        return userModal;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided.');
        case 'invalid-email':
          throw Exception('The email address is not valid.');
        default:
          throw Exception(e.message ?? 'Authentication error');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Register Method
  Future createUserWithEmailPassword(UserModel userModel) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email ?? "",
        password: userModel.password ?? "",
      );

      final user = credential.user;

      if (user != null) {
        final model = UserModel(
          uid: user.uid,
          name: userModel.name,
          email: userModel.email,
          password: userModel.password,
          role: userModel.role,
        );
        await _firestore.collection('users').doc(user.uid).set(model.toMap());
        return model;
      }
    } on FirebaseAuthException catch (e) {
      log.i(e);
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Email is already in use.');
        case 'invalid-email':
          throw Exception('Invalid email format.');
        case 'weak-password':
          throw Exception('Password is too weak.');
        default:
          throw Exception(e.message ?? 'Registration error.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Update user Method
  Future updateUserDetails(UserModel userModel) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("No authenticated user.");
      }

      // Update email if it's changed
      if (userModel.email != null && userModel.email != user.email) {
        await user.updateEmail(userModel.email!);
      }

      // Update password if it's changed
      if (userModel.password != null && userModel.password!.isNotEmpty) {
        await user.updatePassword(userModel.password!);
      }

      // Update user info in Firestore
      final updatedUser = UserModel(
        uid: user.uid,
        name: userModel.name,
        email: userModel.email ?? user.email,
        password: null,
        role: userModel.role,
        proffession: userModel.proffession,
        emailPersonal: userModel.emailPersonal,
        address: userModel.address,
        bio: userModel.bio,
        phoneNumber: userModel.phoneNumber,
        photoUrl: userModel.photoUrl,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(updatedUser.toMap());
      return updatedUser;
    } on FirebaseAuthException catch (e) {
      log.i(e);
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Email is already in use.');
        case 'invalid-email':
          throw Exception('Invalid email format.');
        case 'weak-password':
          throw Exception('Password is too weak.');
        default:
          throw Exception(e.message ?? 'Registration error.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      log.e("Error getting user: $e");
      return null;
    }
  }

  // Logout method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
