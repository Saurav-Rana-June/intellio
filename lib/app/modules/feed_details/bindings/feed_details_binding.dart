import 'package:get/get.dart';

import '../controllers/feed_details_controller.dart';

class FeedDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedDetailsController>(
      () => FeedDetailsController(),
    );
  }
}
