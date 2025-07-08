import 'package:all/all.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  RxList<String> imageUrls = [
    'https://himalayandreamtreks.in/wp-content/uploads/2024/07/Harsil-in-Autumn.webp',
    // 'https://vl-prod-static.b-cdn.net/system/images/000/716/054/bac60df30926eb30c9c051d82421d703/original/harshil.jpg?1725548324',
  ].obs;

  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      int page = pageController.page?.round() ?? 0;
      if (page != currentPage.value) {
        currentPage.value = page;
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
