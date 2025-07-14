import 'package:get/get.dart';

import '../controllers/space_details_controller.dart';

class SpaceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpaceDetailsController>(
      () => SpaceDetailsController(),
    );
  }
}
