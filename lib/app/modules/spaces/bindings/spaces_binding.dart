import 'package:get/get.dart';

import '../controllers/spaces_controller.dart';

class SpacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpacesController>(
      () => SpacesController(),
    );
  }
}
