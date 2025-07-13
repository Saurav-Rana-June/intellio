import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

  final _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      AppMethod.snackbar(
        "Credentials are required!",
        "Email and Password are required",
        SnackBarType.WARNING,
      );
      return;
    }

    try {
      isLoading.value = true;
      final user = await _authService.signInWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        Get.toNamed(Routes.OTP, arguments: {'isFromForgotPassword': false});
        AppMethod.snackbar(
          "Login Successful",
          "User Authenticated successfully...",
          SnackBarType.SUCCESS,
        );
      }
    } catch (e) {
      AppMethod.snackbar(
        "Login Failed",
        "Something gone wrong! $e",
        SnackBarType.ERROR,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
