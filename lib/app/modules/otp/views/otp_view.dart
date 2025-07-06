import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/buttons/custom_primary_button.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final bool isFromForgotPassword =
        arguments['isFromForgotPassword'] ?? false;

    final defaultPinTheme = PinTheme(
      height: 55,
      width: 50,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: primary),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification", style: r18)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'We have shared 6-digit otp code to your registered email address sauravrana77074@gmail.com',
              style: r16,
            ),
            SizedBox(height: 16),

            Form(
              // key: _otpController.formKey,
              child: Column(
                children: [
                  // OTP Fields
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 6,
                    controller: controller.otpController,
                    focusNode: controller.focusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field';
                      }
                      return null;
                    },
                    onCompleted: (value) {
                      controller.verifyOtp();
                    },
                    errorText: "Please enter OTP",
                    errorTextStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                  ),
                  SizedBox(height: 40),

                  // Button
                  CustomPrimaryButton(
                    label: "Verify OTP",
                    onTap: () {
                      if (isFromForgotPassword) {
                        Get.toNamed('/change-password');
                      }
                      Get.toNamed('/home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
