import 'dart:io';

import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:Intellio/app/widgets/buttons/custom_primary_button.dart';
import 'package:Intellio/app/widgets/loader.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/me_controller.dart';
import 'edit_profile_view.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  final MeController controller = Get.put(MeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            controller.isLoading.value
                ? Loader(colors: [primary, primary, primary])
                : buildMeView(context),
      ),
      floatingActionButton: Obx(() {
        final user = controller.userModel.value;

        final hasCompleteProfile =
            user?.proffession?.isNotEmpty == true &&
            user?.phoneNumber?.isNotEmpty == true &&
            user?.address?.isNotEmpty == true;

        return hasCompleteProfile
            ? Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                  Get.to(
                    () =>
                        EditProfileView(userModel: controller.userModel.value),
                  );
                },
                child: Icon(Icons.edit, color: Colors.white),
                backgroundColor: primary,
              ),
            )
            : SizedBox();
      }),
    );
  }

  Widget buildMeView(BuildContext context) {
    final user = controller.userModel.value;

    final hasCompleteProfile =
        user?.proffession?.isNotEmpty == true &&
        user?.phoneNumber?.isNotEmpty == true &&
        user?.address?.isNotEmpty == true;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildTopSection(context),
          SizedBox(height: 16),

          if (hasCompleteProfile)
            buildBodySection(context)
          else
            buildUpdateProfileSection(),
        ],
      ),
    );
  }

  Container buildUpdateProfileSection() {
    return Container(
      height: Get.height / 2,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'It seems like your profile is incomplete. Please update your information to complete your profile and enjoy all features.',
            textAlign: TextAlign.center,
            style: r18.copyWith(),
          ),
          SizedBox(height: 24),

          Container(
            width: Get.width / 2,
            child: CustomPrimaryButton(
              label: "Update Profile",
              onTap: () {
                Get.to(
                  () => EditProfileView(userModel: controller.userModel.value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding buildBodySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio
          Text('Bio', style: r18.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/me.svg",
            null,
            (controller.userModel.value?.bio != null &&
                    controller.userModel.value!.bio!.trim().isNotEmpty)
                ? controller.userModel.value!.bio!
                : "User hasn't updated his bio",
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 16),

          // Email
          Text('Email', style: r18.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/mail.svg",
            "Official",
            (controller.userModel.value?.email != null &&
                    controller.userModel.value!.email!.trim().isNotEmpty)
                ? controller.userModel.value!.email!
                : "Undefined email",
          ),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/mail.svg",
            "Personal",
            (controller.userModel.value?.emailPersonal != null &&
                    controller.userModel.value!.emailPersonal!
                        .trim()
                        .isNotEmpty)
                ? controller.userModel.value!.emailPersonal!
                : "Undefined email",
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 16),

          // Mobile Number
          Text(
            'Mobile number',
            style: r18.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/call.svg",
            null,
            (controller.userModel.value?.phoneNumber != null &&
                    controller.userModel.value!.phoneNumber!.trim().isNotEmpty)
                ? controller.userModel.value!.phoneNumber!
                : "Undefined phone number",
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 16),

          // Address
          Text('Address', style: r18.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/building.svg",
            null,
            (controller.userModel.value?.address != null &&
                    controller.userModel.value!.address!.trim().isNotEmpty)
                ? controller.userModel.value!.address!
                : "Undefined address",
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Row buildProfileOptionTile(String? iconData, String? title, String? content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            iconData ?? "No Icon",
            colorFilter: ColorFilter.mode(primary, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title != null
                  ? Text(
                    title ?? "Untitled",
                    style:
                        title != null
                            ? r14.copyWith(color: regular50)
                            : r18.copyWith(
                              color: regular50,
                              fontWeight: FontWeight.w500,
                            ),
                  )
                  : SizedBox(),
              Container(
                width: Get.width / 1.3,
                child: Text(
                  content ?? "--",
                  style: r16.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildTopSection(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    controller.logout(context);
                  },
                  icon: Icon(Icons.logout, color: white),
                ),
              ],
            ),
            Obx(
              () => CircleAvatar(
                radius: 60,
                backgroundColor: regular50,
                backgroundImage:
                    controller.userModel.value?.photoUrl != null &&
                            controller.userModel.value!.photoUrl!.isNotEmpty
                        ? NetworkImage(controller.userModel.value!.photoUrl!)
                        : null,
                child:
                    controller.userModel.value?.photoUrl != null &&
                            controller.userModel.value!.photoUrl!.isNotEmpty
                        ? null
                        : Icon(Icons.person, size: 80),
              ),
            ),
            SizedBox(height: 16),
            Text(
              (controller.userModel.value?.name != null &&
                      controller.userModel.value!.name!.trim().isNotEmpty)
                  ? controller.userModel.value!.name!
                  : "Undefined Name",
              style: h2.copyWith(color: white),
            ),
            Text(
              (controller.userModel.value?.proffession != null &&
                      controller.userModel.value!.proffession!
                          .trim()
                          .isNotEmpty)
                  ? controller.userModel.value!.proffession!
                  : "Undefined Role",
              style: r14.copyWith(color: white),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildProfileIcon("assets/icons/mail.svg"),
                SizedBox(width: 16),
                buildProfileIcon("assets/icons/call.svg"),
                SizedBox(width: 8),
                Container(
                  height: 40,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                    width: 20,
                  ),
                ),
                SizedBox(width: 8),
                buildProfileIcon("assets/icons/whatsapp.svg"),
                SizedBox(width: 16),
                buildProfileIcon("assets/icons/star.svg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildProfileIcon(String? icon) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: white, width: 1.5),
      ),
      child: SvgPicture.asset(
        icon ?? "",
        height: 10,
        width: 10,
        colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
      ),
    );
  }
}
