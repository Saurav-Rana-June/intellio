import 'dart:core';

import 'dart:core';

import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/enums/snackbar_enum.dart';
import '../../../data/methods/app_methods.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  UserModel? userModel;
  final focusNode = FocusNode();
  RxBool isFromForgotPassword = false.obs;
  RxString registeredEmailAddress = ''.obs;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    isFromForgotPassword.value = arguments['isFromForgotPassword'] ?? false;
    getRegisterdEmailAddress();
    super.onInit();
  }

  getRegisterdEmailAddress() {
    userModel = AppMethod.getUserLocally();
    if (userModel != null  && userModel!.email != null) {
      registeredEmailAddress.value = userModel!.email ?? "";
    }
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
