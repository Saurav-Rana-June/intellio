import 'package:Intellio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../infrastructure/theme/theme.dart';
import '../data/models/feed_models/feed_model.dart';
import '../modules/feed/controllers/feed_controller.dart';

class FeedTileWidget extends StatefulWidget {
  final FeedTileModel feed;

  FeedTileWidget({super.key, required this.feed});

  @override
  State<FeedTileWidget> createState() => _FeedTileWidgetState();
}

class _FeedTileWidgetState extends State<FeedTileWidget> {
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
                  backgroundImage: NetworkImage(
                    widget.feed.userProfileImage ??
                        "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.feed.userName} > ${widget.feed.genre}',
                      style: r16.copyWith(),
                    ),
                    Text(
                      'Posted at ${widget.feed.postedTime}',
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
          widget.feed.feedTitle ?? "Untitled",
          style: r18.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        // Image Carousel
        buildImageSection(context),
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
                    if (widget.feed.currentLikes != null)
                      Text(
                        widget.feed.currentLikes ?? "O",
                        style: r16.copyWith(),
                      )
                    else
                      SizedBox(),
                  ],
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(Icons.mode_comment_outlined),
                    SizedBox(width: 8),
                    if (widget.feed.currentComments != null)
                      Text(
                        widget.feed.currentComments ?? "0",
                        style: r16.copyWith(),
                      ),
                  ],
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(Icons.share_outlined),
                    SizedBox(width: 8),
                    if (widget.feed.currentShare != null)
                      Text(
                        widget.feed.currentShare ?? "0",
                        style: r16.copyWith(),
                      ),
                  ],
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.FEED_DETAILS,
                  arguments: {"feed": widget.feed},
                );
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

  Column buildImageSection(BuildContext context) {
     return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.feed.postImage.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.feed.postImage[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        if (widget.feed.postImage.length > 1)
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.feed.postImage.length, (index) {
                bool isActive = index == currentPage.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: isActive ? 16 : 8,
                  decoration: BoxDecoration(
                    color:
                        isActive ? Theme.of(context).primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            );
          }),
      ],
    );
    // return Obx(() {
    //   if (widget.feed.postImage.isEmpty) return SizedBox.shrink();
    //   return
    // });
  }
}
