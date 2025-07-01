import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void onClose() {
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void verifyOtp() {
    final enteredOtp = otpController.text;
    if (enteredOtp.length == 6) {
      // Your OTP verification logic here
      print('Verifying OTP: $enteredOtp');
    } else {
      Get.snackbar('Invalid OTP', 'Please enter a 6-digit code');
    }
  }
}
