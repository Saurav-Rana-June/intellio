// splash_view.dart
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/splash_controller.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    controller.navigateUser();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 32),
            CircularProgressIndicator(
              color: Get.isDarkMode ? white : primary,
            ),
          ],
        ),
      ),
    );
  }
}
