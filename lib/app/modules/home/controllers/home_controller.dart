import 'package:get/get.dart';

import '../../feed/views/feed_view.dart';
import '../../me/views/me_view.dart';
import '../../search/views/search_view.dart';
import '../../spaces/views/spaces_view.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  final screens = [FeedView(), SearchView(), SpacesView(), MeView()];

  void toggleScreen(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
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
}
