import 'dart:io';

import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/space_models/space_model.dart';
import 'package:Intellio/app/data/services/spaces_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SpacesController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController spaceTextController = TextEditingController();
  final TextEditingController genreTextController = TextEditingController();

  final ValueNotifier<bool> spaceTypeToggleController = ValueNotifier<bool>(
    false,
  );

  RxBool isPrivate = false.obs;
  RxBool loading = false.obs;
  RxBool isAllSpacesActive = true.obs;

  final RxList<String> genreList = <String>[].obs;

  final RxList<String> filteredGenres = <String>[].obs;

  RxString? selectedUploadType = 'Link'.obs;
  RxList<String> uploadType =
      ['Link', 'Video', 'Image', 'Audio', 'PDF', 'Zip Archive'].obs;

  RxList<File> uploadedFiles = <File>[].obs;
  RxList<SpaceModel?> personalSpacesList = <SpaceModel?>[].obs;
  RxList<SpaceModel?> allSpacesList = <SpaceModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSpaces();
    genreTextController.addListener(onSearchChanged);

    // Listen to notifier and update RxBool
    spaceTypeToggleController.addListener(() {
      isPrivate.value = spaceTypeToggleController.value;
    });

    // Optional: Keep RxBool in sync too
    ever(isPrivate, (value) {
      if (spaceTypeToggleController.value != value) {
        spaceTypeToggleController.value = value;
      }
    });
  }

  @override
  void onClose() {
    genreTextController.removeListener(onSearchChanged);
    genreTextController.dispose();
    super.onClose();
  }

  void onSearchChanged() {
    final query = genreTextController.text.toLowerCase();
    if (query.isEmpty) {
      filteredGenres.clear();
    } else {
      filteredGenres.value =
          genreList
              .where((genre) => genre.toLowerCase().contains(query))
              .toList();
    }
  }

  getSpaces() async {
    loading.value = true;
    final currentUser = AppMethod.getUserLocally();
    if (currentUser != null && currentUser.uid != null) {
      SpaceService()
          .getSpacesByUser(currentUser.uid ?? "--")
          .then((value) {
            loading.value = false;
            if (value != null) {
              // Saving all spaces
              allSpacesList.value = value;

              // Filtering only user's created space
              final filteredSpaces =
                  value.where((space) => space.uid == currentUser.uid).toList();
              personalSpacesList.value = filteredSpaces;

              // Saving the name of all spaces in list
              genreList.value =
                  value
                      .where((space) => space.name != null)
                      .map((space) => space.name!)
                      .toList();
            }
          })
          .catchError((error, stackTrace) {
            loading.value = false;
            AppMethod.snackbar(
              "Failed to get spaces",
              "${error}",
              SnackBarType.ERROR,
            );
          });
    } else {
      loading.value = false;
    }
  }

  void onAddSpace() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final id = AppMethod().generateUniqueIdFromText(spaceTextController.text);
      final currentUser = AppMethod.getUserLocally();

      if (currentUser != null && currentUser.uid != null) {
        final spaceReq = SpaceService().createSpace(
          SpaceModel(
            id: id,
            uid: currentUser.uid,
            isPrivate: isPrivate.value,
            name: spaceTextController.text,
          ),
        );

        if (spaceReq != null) {
          Get.back();
          spaceTextController.clear();
          isPrivate.value = false;
          getSpaces();
          AppMethod.snackbar(
            "Creation Successfull",
            "Space created successfully...",
            SnackBarType.SUCCESS,
          );
        }
      }
    } catch (e) {
      Get.back();
      spaceTextController.clear();
      AppMethod.snackbar("Creation Failed", "${e}", SnackBarType.ERROR);
    }
  }

  Future<void> pickImage() async {
    final images = await ImagePicker().pickMultiImage();
    if (images != null) {
      uploadedFiles.addAll(images.map((e) => File(e.path)));
    }
  }

  Future<void> pickVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      uploadedFiles.add(File(video.path));
    }
  }

  Future<void> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );
    if (result != null) {
      uploadedFiles.addAll(result.paths.map((e) => File(e!)));
    }
  }

  Future<void> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      uploadedFiles.addAll(result.paths.map((e) => File(e!)));
    }
  }

  Future<void> pickZip() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
      allowMultiple: true,
    );
    if (result != null) {
      uploadedFiles.addAll(result.paths.map((e) => File(e!)));
    }
  }
}
