import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:Intellio/app/modules/feed/controllers/feed_controller.dart';
import 'package:get/get.dart';

class SpaceDetailsController extends GetxController {
  RxString spaceName = ''.obs;
  RxBool isPrivate = false.obs;
  final feedController = Get.put(FeedController());
  RxList<FeedTileModel> filteredNewFeeds = <FeedTileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    spaceName.value = args['spaceName'] ?? '';
    isPrivate.value = args['isPrivate'] ?? false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  filterFeeds() {
    final filteredFeeds = feedController.feeds.where((feed) {
      return feed.space?.name == spaceName.value;
    }).toList();

    filteredNewFeeds.value = filteredFeeds;
  }
}
