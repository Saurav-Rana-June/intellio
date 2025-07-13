import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/expandable_text.widget.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../../feed/controllers/feed_controller.dart';
import '../controllers/feed_details_controller.dart';
import 'package:Intellio/app/data/models/feed_models/feed_model.dart';

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
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
                  backgroundImage: NetworkImage(
                    controller.feed.userProfileImage ??
                        "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.feed.userName} > ${controller.feed.genre}',
                      style: r16,
                    ),
                    Text(
                      'Posted at ${controller.feed.postedTime}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.more_vert),
          ],
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          controller.feed.feedTitle ?? "Untitled",
          style: r18.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        // Image Carousel
        Obx(() {
          if (controller.feed.postImage.isEmpty) return SizedBox.shrink();
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: controller.feed.postImage.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        controller.feed.postImage[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (controller.feed.postImage.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.feed.postImage.length, (
                    index,
                  ) {
                    bool isActive = index == currentPage.value;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: isActive ? 16 : 8,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
            ],
          );
        }),
        const SizedBox(height: 16),

        // Content
        ExpandableText(
          text: controller.feed.feedContent ?? '',
          style: r16.copyWith(fontWeight: FontWeight.w500),
          maxLines: 15,
        ),
        const SizedBox(height: 16),

        Divider(
          color: Theme.of(context).textTheme.bodySmall?.color,
          thickness: .5,
        ),
        const SizedBox(height: 8),

        // Like, Comment and Share
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(Icons.favorite_border),
                const SizedBox(width: 8),
                Text('Like', style: r16),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.mode_comment_outlined),
                const SizedBox(width: 8),
                Text('Comment', style: r16),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.share_outlined),
                const SizedBox(width: 8),
                Text('Share', style: r16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          color: Theme.of(context).textTheme.bodySmall?.color,
          thickness: .5,
        ),
        const SizedBox(height: 16),
      ],
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
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(5, (_) => buildCommentTile(context)),
        ),
      ],
    );
  }

  Widget buildCommentTexfield() {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(),
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
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primary),
              shape: const WidgetStatePropertyAll(CircleBorder()),
            ),
            child: const Icon(Icons.arrow_forward, size: 18),
          ),
        ],
      ),
    );
  }

  Widget buildCommentTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saurav Rana",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ExpandableText(
                  text:
                      "It is a long established fact that a reader will be distracted by the readable content of a page...",
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
