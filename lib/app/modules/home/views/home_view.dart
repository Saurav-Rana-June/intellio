import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => CircleNavBar(
          activeIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.toggleScreen(index);
          },
          activeIcons: const [
            Icon(Icons.rss_feed, color: Colors.deepPurple),
            // Feed
            Icon(Icons.search, color: Colors.deepPurple),
            // Search
            Icon(Icons.insert_drive_file, color: Colors.deepPurple),
            // Documents
            Icon(Icons.person, color: Colors.deepPurple),
          ],
          inactiveIcons: const [
            Text("Feed"),
            Text("Search"),
            Text("Docs"),
            Text("Me"),
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
          circleColor: Theme.of(context).scaffoldBackgroundColor,
          height: 60,
          circleWidth: 60,
          shadowColor: primary.withValues(alpha: 0.35),
          circleShadowColor: primary.withValues(alpha: 0.35),
          elevation: 2,
        ),
      ),
    );
  }
}
