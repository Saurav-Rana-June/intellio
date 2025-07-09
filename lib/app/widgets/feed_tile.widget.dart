import 'package:Intellio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../infrastructure/theme/theme.dart';
import '../modules/feed/controllers/feed_controller.dart';

class FeedTileWidget extends StatefulWidget {
  const FeedTileWidget({super.key});

  @override
  State<FeedTileWidget> createState() => _FeedTileWidgetState();
}

class _FeedTileWidgetState extends State<FeedTileWidget> {
  final FeedController controller = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Header
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
          if (controller.imageUrls.isEmpty) return SizedBox.shrink();
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.imageUrls.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        controller.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (controller.imageUrls.length > 1)
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.imageUrls.length, (
                      index,
                    ) {
                      bool isActive = index == controller.currentPage.value;
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

        // Like, Comment and Share
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8),
                    Text('20', style: r16.copyWith()),
                  ],
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(Icons.mode_comment_outlined),
                    // SizedBox(width: 8),
                    // Text('20', style: r16.copyWith()),
                  ],
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(Icons.share_outlined),
                    // SizedBox(width: 8),
                    // Text('20', style: r16.copyWith()),
                  ],
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.FEED_DETAILS);
              },
              child: Row(
                children: [
                  Text(
                    'View Full Post',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Divider(
          color: Theme.of(context).textTheme.bodySmall?.color,
          thickness: .5,
        ),
      ],
    );
  }
}
