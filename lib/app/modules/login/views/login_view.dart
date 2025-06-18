import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intellio/app/widgets/fields/custom_form_field.dart';
import 'package:intellio/infrastructure/theme/theme.dart';

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
              children: [
                // Logo
                Text('Intellio', style: h1.copyWith()),
                SizedBox(height: 16),

                // email field
                CustomFormField(
                  controller: TextEditingController(),
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
