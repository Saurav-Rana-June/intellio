import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:Intellio/app/data/services/auth_service.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final user = await _authService.createUserWithEmailPassword(
        UserModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      if (user != null) {
        AppMethod().saveUserLocally(user);
        Get.toNamed(Routes.OTP, arguments: {'isFromForgotPassword': false});
        AppMethod.snackbar(
          "Registration Successfull",
          "Account created successfully...",
          SnackBarType.SUCCESS,
        );
      }
    } catch (e) {
      AppMethod.snackbar("Login Failed", "${e}", SnackBarType.ERROR);
    } finally {
      isLoading.value = false;
    }
  }
}
