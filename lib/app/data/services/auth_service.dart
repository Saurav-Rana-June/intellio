import 'dart:io';
import 'dart:math';

import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthService {
  Logger log = Logger();
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _supabase = supabase.Supabase.instance.client;

  static final _profileBucket = _supabase.storage.from('user-profile-images');

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
      final fb_auth.User? user = credential.user;

      if (user != null) {
        final userModel = await getUserByUid(user.uid);
        return userModel;
      }
    } on fb_auth.FirebaseAuthException catch (e) {
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
    return null;
  }

  // Register Method
  Future<UserModel?> createUserWithEmailPassword(UserModel userModel) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email ?? "",
        password: userModel.password ?? "",
      );

      final fb_auth.User? user = credential.user;

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
    } on fb_auth.FirebaseAuthException catch (e) {
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
    return null;
  }

  // Saving Profile Image to Supabase
  static Future<String?> uploadUserProfileImage(
    File file,
    String userId,
  ) async {
    try {
      final filePath = 'profile_$userId.jpg';
      await _profileBucket.upload(
        filePath,
        file,
        fileOptions: const supabase.FileOptions(upsert: true),
      );
      return _profileBucket.getPublicUrl(filePath);
    } catch (e) {
      print('Failed to upload user profile image: $e');
      return null;
    }
  }

  // Update user Method
  Future<UserModel?> updateUserDetails(UserModel userModel) async {
    try {
      final fb_auth.User? user = _auth.currentUser;
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
    } on fb_auth.FirebaseAuthException catch (e) {
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

  // Get user by uid
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

  fb_auth.User? get currentUser => _auth.currentUser;

  Stream<fb_auth.User?> authStateChanges() => _auth.authStateChanges();
}
