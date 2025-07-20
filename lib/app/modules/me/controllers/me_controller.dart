import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/services/auth_service.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

class MeController extends GetxController {
  final AuthService _authService = AuthService();
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
    super.onClose();
  }

  static Future<bool?> showLogoutConfirmation(BuildContext context) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          'Logout',
          style: r20.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        content: Text(
          'Do you really want to logout?',
          style: r16.copyWith(color: white),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> logout(BuildContext context) async {
    final shouldLogout = await showLogoutConfirmation(context);
    if (shouldLogout == true) {
      try {
        await _authService.signOut();
        await AppMethod().removeUserLocally();
        Get.offAllNamed(Routes.LOGIN);
        AppMethod.snackbar(
          'Logged Out',
          'You have been successfully logged out',
          SnackBarType.SUCCESS,
        );
      } catch (e) {
        AppMethod.snackbar(
          'Logout Failed',
          'Error occurred while logging out: ${e.toString()}',
          SnackBarType.ERROR,
        );
      }
    }
  }
}
