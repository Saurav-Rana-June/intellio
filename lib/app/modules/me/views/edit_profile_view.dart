import 'dart:io';

import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:Intellio/app/modules/me/controllers/me_controller.dart';
import 'package:Intellio/app/widgets/modals/popup.modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/buttons/custom_primary_button.dart';
import '../../../widgets/fields/custom_form_field.dart';

class EditProfileView extends StatefulWidget {
  UserModel? userModel;
  EditProfileView({super.key, required this.userModel});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final MeController controller = Get.put(MeController());

  @override
  void initState() {
    updateFields();
  }

  updateFields() {
    controller.nameTextfield.text = widget.userModel?.name ?? "";
    controller.officialEmailTextfield.text = widget.userModel?.email ?? "";
    controller.proffessionTextfield.text = widget.userModel?.proffession ?? "";
    controller.personalEmailTextfield.text =
        widget.userModel?.emailPersonal ?? "";
    controller.phoneNumberTextfield.text = widget.userModel?.phoneNumber ?? "";
    controller.addressTextfield.text = widget.userModel?.address ?? "";
    controller.bioTextfield.text = widget.userModel?.bio ?? "";
    controller.imageFile.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Profile",
          style: r20.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
              Obx(
                () => Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CustomPrimaryButton(
                    label:
                        controller.updateLoading.value
                            ? "Updating... Please wait"
                            : "Update Profile",
                    isDisabled: controller.updateLoading.value,
                    isLoading: controller.updateLoading.value,
                    onTap: () => controller.updateUserData(),
                  ),
                ),
              ),
            ],
          ),
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
          controller: controller.nameTextfield,
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
          controller: controller.proffessionTextfield,
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
          controller: controller.officialEmailTextfield,
          hintText: 'Enter your official email',
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
          controller: controller.personalEmailTextfield,
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
          controller: controller.phoneNumberTextfield,
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
          controller: controller.addressTextfield,
          hintText: 'Enter your address',
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
          controller: controller.bioTextfield,
          hintText: 'Enter your bio',
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
            Obx(
              () => CircleAvatar(
                radius: 50,
                backgroundColor: regular50,
                backgroundImage:
                    controller.imageFile.value != null
                        ? FileImage(File(controller.imageFile.value!.path))
                        : widget.userModel!.photoUrl != null
                        ? NetworkImage(controller.userModel.value!.photoUrl!)
                        : null,
                child:
                    controller.imageFile.value == null &&
                            widget.userModel!.photoUrl == null
                        ? Icon(Icons.person, size: 50)
                        : null,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.showImageSourceActionSheet(context);
              },
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
