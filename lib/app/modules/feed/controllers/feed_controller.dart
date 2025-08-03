import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  RxList<FeedTileModel> feeds = <FeedTileModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFeeds();
    super.onInit();
  }

  getFeeds() async {
    isLoading.value = true;

    final currentUser = AppMethod.getUserLocally();

    if (currentUser != null && currentUser.uid != null) {
      FeedService.fetchFeeds()
          .then((value) {
            isLoading.value = false;
            if (value != null) {
              feeds.value = value;
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
