import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SpacesController extends GetxController {
  final TextEditingController genreTextController = TextEditingController();

  RxBool isPrivate = false.obs;

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

  @override
  void onInit() {
    super.onInit();
    genreTextController.addListener(onSearchChanged);
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
