import 'dart:io';

import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:all/all.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FeedController extends GetxController {
  var currentFeedId = "".obs;
  var currentAudioIndex = (-1).obs;

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

  Future<void> downloadZipFile(String fileUrl) async {
    try {
      // Step 1: Get a directory to save the file
      Directory dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/downloaded.zip";

      // Step 2: Start downloading
      Dio dio = Dio();
      await dio.download(
        fileUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      AppMethod.snackbar(
        "Downloaded Successfully",
        filePath,
        SnackBarType.SUCCESS,
      );
      await OpenFile.open(filePath);
    } catch (e) {
      AppMethod.snackbar("Download Failed", "${e}", SnackBarType.ERROR);
      print(e);
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
