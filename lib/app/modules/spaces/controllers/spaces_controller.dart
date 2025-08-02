import 'dart:io';

import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/space_models/space_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:Intellio/app/data/services/spaces_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/feed_models/feed_model.dart';

class SpacesController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController spaceTextController = TextEditingController();
  final TextEditingController genreTextController = TextEditingController();
  final TextEditingController feedTitleController = TextEditingController();
  final TextEditingController feedDescriptionController =
      TextEditingController();
  final TextEditingController feedLinkController = TextEditingController();

  final ValueNotifier<bool> spaceTypeToggleController = ValueNotifier<bool>(
    false,
  );

  RxBool isPrivate = false.obs;
  RxBool loading = false.obs;

  RxList<String> genreList =
      [
        'Comedy',
        'Science',
        'Horror',
        'Adventure',
        'Entertainment',
        'Music',
        'Memes',
      ].obs;

  final RxList<String> filteredGenres = <String>[].obs;

  RxString? selectedUploadType = 'Link'.obs;
  RxList<String> uploadType =
      ['Link', 'Video', 'Image', 'Audio', 'PDF', 'Zip Archive'].obs;

  RxList<File> uploadedFiles = <File>[].obs;
  RxList<SpaceModel?> spaceModelList = <SpaceModel?>[].obs;

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
    final String? uid = auth.currentUser?.uid;
    if (uid != null) {
      SpaceService()
          .getSpacesByUser(uid)
          .then((value) {
            loading.value = false;
            if (value != null) {
              spaceModelList.value = value;
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
      final String? uid = auth.currentUser?.uid;
      final spaceReq = SpaceService().createSpace(
        SpaceModel(
          id: id,
          uid: uid,
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

  void onAddFeed() async {
    final uploadedUrls = <String>[];
    final postId = DateTime.now().millisecondsSinceEpoch.toString();

    for (final file in uploadedFiles) {
      final extension = file.path.split('.').last;
      final url = await FeedService.uploadFeedFile(
        file: file,
        postId: postId,
        extension: extension,
      );
      if (url != null) {
        uploadedUrls.add(url);
      } else {
        AppMethod.snackbar(
          "Upload Failed",
          "Unable to upload media...",
          SnackBarType.ERROR,
        );
      }
    }

    await FeedService.addFeed(
      FeedTileModel(
        userProfileImage: '',
        userName: 'Test Name',
        genre: genreTextController.text.trim(),
        postedTime: DateTime.now().toIso8601String(),
        feedTitle: feedTitleController.text,
        feedDescription: feedDescriptionController.text,
        currentLikes: '0',
        currentComments: '0',
        currentShare: '0',
        postImage: uploadedUrls,
      ),
    );
  }
}
