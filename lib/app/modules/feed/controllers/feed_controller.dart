import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:all/all.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
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

  Future playAudio(String url) async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      isAudioLoading.value = true;
      await audioPlayer.play(UrlSource(url));
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
