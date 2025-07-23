import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/auth/user_model.dart';
import 'package:Intellio/app/data/services/auth_service.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MeController extends GetxController {
  final AuthService _authService = AuthService();
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;
  RxBool updateLoading = false.obs;

  TextEditingController nameTextfield = TextEditingController();
  TextEditingController proffessionTextfield = TextEditingController();
  TextEditingController officialEmailTextfield = TextEditingController();
  TextEditingController personalEmailTextfield = TextEditingController();
  TextEditingController phoneNumberTextfield = TextEditingController();
  TextEditingController addressTextfield = TextEditingController();
  TextEditingController bioTextfield = TextEditingController();

  Rx<XFile?> imageFile = Rx<XFile?>(null);

  @override
  void onInit() {
    getUserData();
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

  getUserData() async {
    isLoading.value = true;
    final currentUser = AppMethod.getUserLocally();
    if (currentUser != null && currentUser.uid != null) {
      userModel.value = await _authService.getUserByUid(currentUser.uid ?? '');
      isLoading.value = false;
    } else {
      AppMethod.snackbar(
        'Error',
        'Unable to get current user or its uid',
        SnackBarType.ERROR,
      );
      isLoading.value = false;
    }
  }

  updateUserData() async {
    updateLoading.value = true;
    try {
      final user = await _authService.updateUserDetails(
        UserModel(
          name: nameTextfield.text,
          email: officialEmailTextfield.text,
          proffession: proffessionTextfield.text,
          emailPersonal: personalEmailTextfield.text,
          address: addressTextfield.text,
          phoneNumber: phoneNumberTextfield.text,
          bio: bioTextfield.text,
          photoUrl: imageFile.value?.path,
        ),
      );

      if (user != null) {
        AppMethod().saveUserLocally(user);
        Get.back();
        AppMethod.snackbar(
          "Update Successfull",
          "User details updated successfully...",
          SnackBarType.SUCCESS,
        );
        getUserData();
      }
    } catch (e) {
      AppMethod.snackbar("Login Failed", "${e}", SnackBarType.ERROR);
    } finally {}
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
            child: Text('Cancel', style: r14.copyWith(color: primary)),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primary),
            ),
            child: Text('Logout', style: r14.copyWith(color: white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile.value = pickedFile;
    }
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take a photo', style: r16.copyWith()),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Choose from gallery', style: r16.copyWith()),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
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
