import 'package:flutter/material.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/buttons/custom_primary_button.dart';
import '../../../widgets/fields/custom_form_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: r20.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildProfilePictureSection(),
                  SizedBox(height: 24),
                  buildEditProfileFields(),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: CustomPrimaryButton(
                label: "Register",
                onTap: () {
                  // Get.toNamed('/otp');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildEditProfileFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text('Name', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
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

        // Proffession
        Text('Proffession', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your proffession',
          prefixIcon: Icons.person_2_outlined,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Proffession is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Official Email
        Text('Offical Email', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your email',
          prefixIcon: Icons.mail_outline_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Official email is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Official Email
        Text('Personal Email', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your email',
          prefixIcon: Icons.mail_outline_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Personal email is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Official Phone Number
        Text('Phone Number', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Address
        Text('Address', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your address',
          prefixIcon: Icons.house_outlined,
          keyboardType: TextInputType.text,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Bio
        Text('Bio', style: r16.copyWith()),
        SizedBox(height: 8),
        CustomFormField(
          controller: TextEditingController(),
          hintText: 'Enter your bio',
          prefixIcon: Icons.house_outlined,
          keyboardType: TextInputType.text,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bio is required';
            }
            return null;
          },
        ),
        SizedBox(height: 24),
        SizedBox(height: 24),
        SizedBox(height: 24),
      ],
    );
  }

  Row buildProfilePictureSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(radius: 50, backgroundColor: regular50),
            IconButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(primary),
              ),
              icon: Icon(Icons.edit, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
