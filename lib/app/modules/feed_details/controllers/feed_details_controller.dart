import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/models/feed_models/feed_comment_model.dart';
import 'package:Intellio/app/data/services/feed_service.dart';
import 'package:Intellio/app/modules/feed/controllers/feed_controller.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

import '../../../data/models/feed_models/feed_model.dart';

class FeedDetailsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late FeedTileModel feed;
  RxList<FeedCommentModel> feedComments = <FeedCommentModel>[].obs;
  final feedController = Get.put(FeedController());

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

  void onAddComment() async {
    if (formKey.currentState!.validate()) {
      final currentUser = AppMethod.getUserLocally();

      if (currentUser != null && currentUser.name != null) {
        feedComments.add(
          FeedCommentModel(
            comment: commentController.text,
            userName: currentUser.name,
            userProfileImage: currentUser.photoUrl,
          ),
        );
      } 

      final value = await FeedService.addComments(
        feedId: feed.docId ?? "--",
        comment: FeedCommentModel(
          comment: commentController.text,
          userName: currentUser?.name,
          userProfileImage: currentUser?.photoUrl,
        ),
      );

      if (value == true) {
        // uploading.value = false;
        Get.back();
        feedController.getFeeds();
        AppMethod.snackbar(
          "Commented Successfully",
          "Comment added successfully...",
          SnackBarType.SUCCESS,
        );
      } else {
        // uploading.value = false;
        Get.back();
        AppMethod.snackbar(
          "Comment Failed",
          "There is some issue in commenting in this feed...",
          SnackBarType.ERROR,
        );
      }
    }
  }
}
