// splash_controller.dart
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> navigateUser() async {
    await Future.delayed(const Duration(seconds: 4)); // Minimum splash duration
    
    try {
      final UserModel? userModel = AppMethod.getUserLocally();
      final route = (userModel != null && userModel.uid!.isNotEmpty) 
          ? Routes.HOME 
          : Routes.LOGIN;
      Get.offAllNamed(route);
    } catch (e) {
      Get.offAllNamed(Routes.LOGIN); // Fallback to login if error occurs
    }
  }
}