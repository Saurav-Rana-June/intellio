import 'package:Intellio/app/modules/spaces/controllers/spaces_controller.dart';
import 'package:Intellio/app/widgets/buttons/custom_primary_button.dart';
import 'package:Intellio/app/widgets/fields/custom_dropdown_field.dart';
import 'package:Intellio/app/widgets/fields/custom_form_field.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/models/auth/user_model.dart';
import '../../../data/models/feed_models/feed_model.dart';
import '../../../data/services/auth_service.dart';

class AddFeedView extends StatefulWidget {
  const AddFeedView({super.key});

  @override
  State<AddFeedView> createState() => _AddFeedViewState();
}

class _AddFeedViewState extends State<AddFeedView> {
  final spacesController = Get.put(SpacesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Feed",
          style: r20.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: buildAddFeedForm(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: CustomPrimaryButton(
            label:
                spacesController.uploading.value
                    ? "Uploading... Please wait"
                    : "Add Feed",
            isLoading: spacesController.uploading.value,
            isDisabled:
                spacesController.genreList.isEmpty
                    ? true
                    : spacesController.uploading.value,
            onTap: () {
              if (!spacesController.formKey.currentState!.validate()) {
                return;
              }
              spacesController.onAddFeed();
            },
          ),
        ),
      ),
    );
  }

  Form buildAddFeedForm() {
    return Form(
      key: spacesController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text('Title', style: r16.copyWith()),
          SizedBox(height: 8),
          CustomFormField(
            controller: spacesController.feedTitleController,
            hintText: 'Title',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),
          SizedBox(height: 24),

          // Description
          Text('Description', style: r16.copyWith()),
          SizedBox(height: 8),
          CustomFormField(
            controller: spacesController.feedDescriptionController,
            hintText: 'description...',
            keyboardType: TextInputType.text,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Description is required';
              }
              return null;
            },
          ),
          SizedBox(height: 24),

          // Genre
          Text('Space', style: r16.copyWith()),
          SizedBox(height: 8),
          CustomFormField(
            controller: spacesController.genreTextController,
            hintText:
                spacesController.genreList.isEmpty
                    ? 'No Spaces available'
                    : 'Space',
            readOnly: spacesController.genreList.isEmpty ? true : false,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Space is required';
              }
              return null;
            },
          ),
          spacesController.genreList.isEmpty
              ? Text(
                "There isn’t any space available currently, so first make one",
                style: r12.copyWith(fontStyle: FontStyle.italic),
              )
              : SizedBox(),

          Obx(() {
            if (spacesController.filteredGenres.isEmpty) {
              return SizedBox();
            }

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: regular50.withValues(alpha: 0.3),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: spacesController.filteredGenres.length,
                itemBuilder: (context, index) {
                  final genre = spacesController.filteredGenres[index];
                  return InkWell(
                    onTap: () {
                      spacesController.genreTextController.text = genre;
                      spacesController.filteredGenres.clear();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/folder.svg',
                            height: 18,
                            width: 18,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyMedium!.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 10),

                          Text(genre),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 24),

          // Type
          Text('Type', style: r16.copyWith()),
          SizedBox(height: 8),
          Obx(
            () => CustomDropdown<String>(
              items: spacesController.uploadType,
              value: spacesController.selectedUploadType?.value,
              itemToString: (item) => item,
              onChanged: (val) {
                spacesController.selectedUploadType?.value = val ?? '';
                spacesController.uploadedFiles.clear();
              },
            ),
          ),
          SizedBox(height: 24),

          Obx(() => buildUploadSection()),
        ],
      ),
    );
  }

  Column buildUploadSection() {
    switch (spacesController.selectedUploadType?.value) {
      case 'Link':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Link', style: r16.copyWith()),
            SizedBox(height: 8),
            CustomFormField(
              controller: spacesController.feedLinkController,
              hintText: 'https://...',
              prefixIcon: Icons.link,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Link is required';
                }
                return null;
              },
            ),
          ],
        );

      case 'Video':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload Video', style: r16.copyWith()),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: regular50.withAlpha(30), // Correct alpha usage
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    spacesController.pickVideo();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Upload Videos"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    spacesController.uploadedFiles.map((file) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary.withValues(alpha: 0.25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.video_file,
                                      size: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(file.path.split('/').last),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                spacesController.uploadedFiles.remove(file);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );

      case 'Image':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload Images', style: r16.copyWith()),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: regular50.withAlpha(30), // Correct alpha usage
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    spacesController.pickImage();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Upload Images"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    spacesController.uploadedFiles.map((file) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary.withValues(alpha: 0.25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(file.path.split('/').last),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                spacesController.uploadedFiles.remove(file);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );

      case 'Audio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload Audio', style: r16.copyWith()),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: regular50.withAlpha(30), // Correct alpha usage
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    spacesController.pickAudio();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Upload Audios"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    spacesController.uploadedFiles.map((file) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary.withValues(alpha: 0.25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.audio_file,
                                      size: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(file.path.split('/').last),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                spacesController.uploadedFiles.remove(file);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      case 'PDF':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload PDF', style: r16.copyWith()),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: regular50.withAlpha(30), // Correct alpha usage
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    spacesController.pickPDF();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Upload PDFs"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    spacesController.uploadedFiles.map((file) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary.withValues(alpha: 0.25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.picture_as_pdf_rounded,
                                      size: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(file.path.split('/').last),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                spacesController.uploadedFiles.remove(file);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );

      case 'Zip Archive':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload Zip', style: r16.copyWith()),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: regular50.withAlpha(30), // Correct alpha usage
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    spacesController.pickZip();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Upload Zip file"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    spacesController.uploadedFiles.map((file) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary.withValues(alpha: 0.25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.folder_zip,
                                      size: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(file.path.split('/').last),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                spacesController.uploadedFiles.remove(file);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );

      default:
        return Column(children: [Text('Please select a file type.')]);
    }
  }
}
