import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/me_controller.dart';
import 'edit_profile_view.dart';

class MeView extends GetView<MeController> {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTopSection(),
            SizedBox(height: 16),
            buildBodySection(context),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Get.to(() => EditProfileView());
          },
          child: Icon(Icons.edit, color: Colors.white),
          backgroundColor: primary,
        ),
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
            "This is just a example bio... This is just an example bio and this is example. This is just an example bio and this is example. This is just an example bio and this is example.",
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
            "saurav@ekodemy.in",
          ),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/mail.svg",
            "Personal",
            "sauravrana77074@gmail.com",
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
          buildProfileOptionTile("assets/icons/call.svg", null, "9027966724"),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 16),

          // Address
          Text('Address', style: r18.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          buildProfileOptionTile(
            "assets/icons/building.svg",
            null,
            "Tehri Visthapit Colorny Shyampur Rishikesh, Uttarkhand 249204",
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              width: Get.width / 1.5,
              child: Text(
                content ?? "--",
                style: r16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildTopSection() {
    return Container(
      height: Get.height / 2.5,
      width: Get.width,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 60, child: Icon(Icons.person, size: 80)),
          SizedBox(height: 16),
          Text('Saurav Rana', style: h2.copyWith(color: white)),
          Text('Flutter Developer', style: r14.copyWith(color: white)),
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
        colorFilter: ColorFilter.mode(
          white,
          BlendMode.srcIn, // Most common for solid coloring
        ),
      ),
    );
  }
}
