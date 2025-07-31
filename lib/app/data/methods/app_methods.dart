import 'dart:math';

import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:all/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../infrastructure/theme/theme.dart';
import '../enums/snackbar_enum.dart';

class AppMethod {
  static void snackbar(
    String title,
    String message,
    SnackBarType type, {
    TextButton? actionButton,
    Duration? duration = const Duration(seconds: 3),
  }) {
    Color color;
    IconData icon;

    switch (type) {
      case SnackBarType.SUCCESS:
        color = successColor;
        icon = CupertinoIcons.checkmark_alt_circle_fill;
        break;
      case SnackBarType.ERROR:
        color = dangerColor;
        icon = CupertinoIcons.clear_circled_solid;
        break;
      case SnackBarType.WARNING:
        color = warningColor;
        icon = CupertinoIcons.exclamationmark_circle_fill;
        break;
      case SnackBarType.INFO:
        color = infoColor;
        icon = CupertinoIcons.info_circle_fill;
        break;
      default:
        color = regular;
        icon = CupertinoIcons.add_circled;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: white,
      dismissDirection: DismissDirection.horizontal,
      shouldIconPulse: false,
      duration: duration,
      icon: Icon(icon, color: color, size: 26.0),
      mainButton: actionButton,
      colorText: regular,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 0.0,
      leftBarIndicatorColor: color,
      overlayBlur: 0,
      barBlur: 0,
      boxShadows: [
        BoxShadow(
          color: regular.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Future<bool> saveUserLocally(UserModel user) async {
    final box = GetStorage();
    await box.write('user', user.toMap());
    return true;
  }

  static UserModel? getUserLocally() {
    final box = GetStorage();
    Map<String, dynamic>? json = box.read('user');
    if (json == null) {
      return null;
    }
    return UserModel.fromMap(json);
  }

  removeUserLocally() async {
    final box = GetStorage();
    await box.remove('user');
  }

// Generate random
  String generateUniqueIdFromText(String input, {int suffixLength = 8}) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_-+=';

    final lowerInput = input.toLowerCase().replaceAll(RegExp(r'\s+'), '');

    String randomSuffix =
        List.generate(suffixLength, (index) {
          return chars[random.nextInt(chars.length)];
        }).join();

    return '$lowerInput\_$randomSuffix';
  }
}
