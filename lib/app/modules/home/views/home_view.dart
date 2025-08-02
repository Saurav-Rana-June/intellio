import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => CircleNavBar(
          activeIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.toggleScreen(index);
          },
          activeIcons: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/feed.svg',
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    primary,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                ),

                Text("Feed", style: r14),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    primary,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                ),

                Text("Search", style: r14),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/folder.svg',
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    primary,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                ),

                Text("Spaces", style: r14),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/me.svg',
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    primary,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                ),

                Text("Me", style: r14),
              ],
            ),
          ],
          inactiveIcons: [
            SvgPicture.asset(
              'assets/icons/feed.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium!.color!,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            SvgPicture.asset(
              'assets/icons/search.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium!.color!,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            SvgPicture.asset(
              'assets/icons/folder.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium!.color!,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            SvgPicture.asset(
              'assets/icons/me.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium!.color!,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
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
