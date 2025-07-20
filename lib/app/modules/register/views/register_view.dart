import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/buttons/custom_primary_button.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 48),
                // Into
                Text('Register', style: h1.copyWith()),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Create an account to get started and enjoy our full features.',
                    style: r16.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: r16.copyWith()),
                      SizedBox(height: 8),
                      CustomFormField(
                        controller: controller.nameController,
                        hintText: 'Enter your name',
                        prefixIcon: Icons.person_2_outlined,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),

                      // email field
                      Text('Email', style: r16.copyWith()),
                      SizedBox(height: 8),
                      CustomFormField(
                        controller: controller.emailController,
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
                        controller: controller.passwordController,
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

                      SizedBox(height: 40),

                      Obx(
                        () => CustomPrimaryButton(
                          label: "Register",
                          isLoading: controller.isLoading.value,
                          isDisabled: controller.isLoading.value,
                          onTap: () => controller.registerUser(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
