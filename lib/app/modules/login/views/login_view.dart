import 'package:Intellio/app/widgets/fields/custom_form_field.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../widgets/buttons/custom_primary_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 40,
                      height: 40,
                      colorFilter:
                          Theme.of(context).brightness == Brightness.dark
                              ? ColorFilter.mode(white, BlendMode.srcIn)
                              : null,
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // email field
                Text('Email', style: r16.copyWith()),
                SizedBox(height: 8),
                CustomFormField(
                  controller: TextEditingController(),
                  hintText: 'Enter your email',
                  prefixIcon: Icons.mail_outline_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // password field
                Text('Password', style: r16.copyWith()),
                SizedBox(height: 8),
                CustomFormField(
                  controller: TextEditingController(),
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(
                          '/otp',
                          arguments: {'isFromForgotPassword': true},
                        );
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: r16.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                CustomPrimaryButton(
                  label: "Login",
                  onTap: () {
                    Get.toNamed(
                      '/otp',
                      arguments: {'isFromForgotPassword': false},
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Are you a new user ?', style: r16.copyWith()),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      child: Text(
                        'Register Here',
                        style: r16.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
