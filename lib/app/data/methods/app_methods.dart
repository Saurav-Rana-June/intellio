import 'package:all/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
