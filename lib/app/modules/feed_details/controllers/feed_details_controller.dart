import 'package:all/all.dart';
import 'package:get/get.dart';

import '../../../data/models/feed_models/feed_model.dart';

class FeedDetailsController extends GetxController {
  final TextEditingController commentController = TextEditingController();
  late FeedTileModel feed;

  final count = 0.obs;

  @override
  void onInit() {
    final args = Get.arguments;
    feed = args['feed'] as FeedTileModel;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
