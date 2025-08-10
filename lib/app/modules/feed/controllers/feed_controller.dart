import 'dart:io';

import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:Intellio/app/widgets/modals/popup.modal.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:all/all.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FeedController extends GetxController {
  var currentFeedId = "".obs;
  var currentAudioIndex = (-1).obs;

  var progress = 0.0.obs;

  final audioPlayer = AudioPlayer();
  RxList<FeedTileModel> feeds = <FeedTileModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isAudioLoading = false.obs;

  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    getFeeds();
    super.onInit();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        isPlaying.value = true;
        isAudioLoading.value = false;
      } else {
        isPlaying.value = false;
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future playAudio({
    required String url,
    required String feedId,
    required int mediaIndex,
  }) async {
    if (currentFeedId.value != feedId ||
        currentAudioIndex.value != mediaIndex) {
      await audioPlayer.stop();
      currentFeedId.value = feedId;
      currentAudioIndex.value = mediaIndex;
    }

    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      isAudioLoading.value = true;
      await audioPlayer.play(UrlSource(url));
    }
  }

  Future<void> downloadZipFile(String fileUrl, String fileName) async {
    try {
      progress.value = 0;

      String filePath = "/storage/emulated/0/Download/$fileName.zip";

      File file = File(filePath);

      if (await file.exists()) {
        bool downloadAgain =
            await Get.dialog<bool>(
              CustomPopupModal(
                title: 'File Already Exists',
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      Text(
                        'The file "$fileName.zip" already exists in Downloads. Do you want to download it again and overwrite it ?',
                        style: r14,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: Text(
                              'Cancel',
                              style: r16.copyWith(color: primary),
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () => Get.back(result: true),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(primary),
                            ),
                            child: Text(
                              'Download Again',
                              style: r16.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ) ??
            false;
      }
      Get.dialog(
        Obx(
          () => CustomPopupModal(
            title: 'Downloading',
            content: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: progress.value),
                  SizedBox(height: 8),
                  Text(
                    "${(progress.value * 100).toStringAsFixed(0)}%",
                    style: r14.copyWith(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Back',
                          style: r16.copyWith(color: primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      Dio dio = Dio();
      await dio.download(
        fileUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progress.value = received / total;
          }
        },
      );

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      AppMethod.snackbar(
        "Downloaded Successfully",
        filePath,
        SnackBarType.SUCCESS,
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppMethod.snackbar("Download Failed", "$e", SnackBarType.ERROR);
    }
  }

  getFeeds() async {
    isLoading.value = true;

    final currentUser = AppMethod.getUserLocally();

    if (currentUser != null && currentUser.uid != null) {
      FeedService.fetchFeeds()
          .then((value) {
            isLoading.value = false;
            if (value != null) {
              feeds.value =
                  value
                      .where(
                        (feed) =>
                            !(feed.space?.isPrivate == true &&
                                feed.uid != currentUser.uid),
                      )
                      .toList();
            } else {
              AppMethod.snackbar(
                "Feeds not found",
                "There isn't any feeds available...",
                SnackBarType.ERROR,
              );
            }
          })
          .catchError((error) {
            isLoading.value = false;
            AppMethod.snackbar(
              "Feeds not found",
              "There isn't any feeds available...",
              SnackBarType.ERROR,
            );
          });
    } else {
      AppMethod.snackbar(
        "Unauthenticated User",
        "User not found..",
        SnackBarType.ERROR,
      );
    }
  }
}
