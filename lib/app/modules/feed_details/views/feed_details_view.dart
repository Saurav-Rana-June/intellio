import 'package:Intellio/app/data/models/feed_models/feed_comment_model.dart';
import 'package:Intellio/app/widgets/feed_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/expandable_text.widget.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/feed_details_controller.dart';

class FeedDetailsView extends StatefulWidget {
  const FeedDetailsView({super.key});

  @override
  State<FeedDetailsView> createState() => _FeedDetailsViewState();
}

class _FeedDetailsViewState extends State<FeedDetailsView> {
  final FeedDetailsController controller = Get.put(FeedDetailsController());

  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  @override
  void initState() {
    pageController.addListener(() {
      int page = pageController.page?.round() ?? 0;
      if (page != currentPage.value) {
        currentPage.value = page;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailFeedSection(context),
              buildCommentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Column buildDetailFeedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [FeedTileWidget(feed: controller.feed, fromFeedDetail: true)],
    );
  }

  Column buildCommentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Comment Section", style: r18),
        const SizedBox(height: 16),
        buildCommentTexfield(),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.feed.commentSection?.length,
          itemBuilder: (context, index) {
            return buildCommentTile(
              context,
              controller.feed.commentSection![index],
            );
          },
        ),
      ],
    );
  }

  Widget buildCommentTexfield() {
    return SizedBox(
      width: Get.width,
      child: Form(
        key: controller.formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
                  backgroundImage: NetworkImage(
                    controller.feed.userProfileImage ??
                        "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: Get.width / 1.8,
                  child: CustomFormField(
                    controller: controller.commentController,
                    hintText: 'Comment here...',
                    prefixIcon: Icons.mode_comment_outlined,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Comment is required';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.onAddComment,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(primary),
                shape: const WidgetStatePropertyAll(CircleBorder()),
              ),
              child: const Icon(Icons.arrow_forward, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCommentTile(BuildContext context, FeedCommentModel comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
            backgroundImage: NetworkImage(
              comment.userProfileImage ??
                  "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName ?? "Unknown User",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ExpandableText(
                  text: comment.comment ?? "--",
                  style: r16.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
