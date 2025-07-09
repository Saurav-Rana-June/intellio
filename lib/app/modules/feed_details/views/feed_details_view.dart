import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/expandable_text.widget.dart';
import '../../feed/controllers/feed_controller.dart';
import '../controllers/feed_details_controller.dart';

class FeedDetailsView extends GetView<FeedDetailsController> {
  FeedDetailsView({super.key});

  final FeedController feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header
              buildDetailFeedSection(context),
              // Comment Section
              buildCommentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Column buildDetailFeedSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username > Comedy', style: r16.copyWith()),
                    Text(
                      'Posted at 1:14 PM',
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
          'This is the dummy title for this feed tile... for Testing purpose.',
          style: r18.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        // Image Carousel
        Obx(() {
          if (feedController.imageUrls.isEmpty) return SizedBox.shrink();
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: feedController.pageController,
                  itemCount: feedController.imageUrls.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        feedController.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (feedController.imageUrls.length > 1)
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(feedController.imageUrls.length, (
                      index,
                    ) {
                      bool isActive = index == feedController.currentPage.value;
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
                  );
                }),
            ],
          );
        }),
        const SizedBox(height: 16),

        // Content
        ExpandableText(
          text:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." +
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." +
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." +
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          style: r16.copyWith(fontWeight: FontWeight.w500),
          maxLines: 15,
        ),
        const SizedBox(height: 16),

        // Like, Comment and Share
        Divider(
          color: Theme.of(context).textTheme.bodySmall?.color,
          thickness: .5,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 8),
                Text('Like', style: r16.copyWith()),
              ],
            ),
            SizedBox(width: 24),
            Row(
              children: [
                Icon(Icons.mode_comment_outlined),
                SizedBox(width: 8),
                Text('Comment', style: r16.copyWith()),
              ],
            ),
            SizedBox(width: 24),
            Row(
              children: [
                Icon(Icons.share_outlined),
                SizedBox(width: 8),
                Text('Share', style: r16.copyWith()),
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
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            buildCommentTile(context),
            buildCommentTile(context),
            buildCommentTile(context),
            buildCommentTile(context),
          ],
        ),
      ],
    );
  }

  Column buildCommentTile(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(),
            SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saurav Rana",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ExpandableText(
                    text:
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                    style: r16.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
