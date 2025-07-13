import 'dart:core';

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/enums/snackbar_enum.dart';
import '../../../data/methods/app_methods.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final focusNode = FocusNode();
  RxBool isFromForgotPassword = false.obs;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    isFromForgotPassword.value = arguments['isFromForgotPassword'] ?? false;
    super.onInit();
  }

  @override
  void onClose() {
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void verifyOtp() {
    final enteredOtp = otpController.text;
    if (enteredOtp.length == 6) {
      if (enteredOtp == "902796") {
        if (isFromForgotPassword.value) {
          Get.toNamed('/change-password');
          otpController.clear();
        } else {
          Get.toNamed('/home');
          otpController.clear();
        }
      } else {
        AppMethod.snackbar(
          "Invalid OTP",
          "Please enter valid OTP",
          SnackBarType.ERROR,
        );
        otpController.clear();
      }
    } else {
      AppMethod.snackbar(
        "Invalid OTP",
        "Please enter a 6-digit code",
        SnackBarType.WARNING,
      );
    }
  }
}
