import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/buttons/custom_primary_button.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password", style: r18)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text('New Password', style: r16.copyWith()),
            SizedBox(height: 8),
            CustomFormField(
              controller: TextEditingController(),
              hintText: 'Enter your new password',
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
            SizedBox(height: 24),

            Text('Confirm Password', style: r16.copyWith()),
            SizedBox(height: 8),
            CustomFormField(
              controller: TextEditingController(),
              hintText: 'Confirm your new password',
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

            CustomPrimaryButton(label: "Confirm Change", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
