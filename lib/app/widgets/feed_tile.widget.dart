import 'package:Intellio/app/data/methods/datetime_methods.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:Intellio/app/widgets/image_viewer.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                    Row(
                      children: [
                        Text('${widget.feed.userName}', style: r16.copyWith()),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          height: 15,
                          width: 15,
                          colorFilter: ColorFilter.mode(
                            primary,
                            BlendMode.srcIn, // Most common for solid coloring
                          ),
                        ),
                        SizedBox(width: 4),
                        Text('${widget.feed.space}', style: r16.copyWith()),
                      ],
                    ),
                    Text(
                      'Posted at ${DateTimeMethods.convertDateTimeToHumanDate(widget.feed.postedTime != null ? DateTime.parse(widget.feed.postedTime!) : null)}',
                      style: r12.copyWith(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
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
        const SizedBox(height: 24),

        // Like, Comment and Share
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/favourite.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyMedium!.color!,
                        BlendMode.srcIn,
                      ),
                    ),

                    SizedBox(width: 5),
                    if (widget.feed.currentLikes != null)
                      Text(
                        widget.feed.currentLikes ?? "O",
                        style: r16.copyWith(),
                      )
                    else
                      SizedBox(),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/comment.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyMedium!.color!,
                        BlendMode.srcIn,
                      ),
                    ),

                    SizedBox(width: 5),
                    if (widget.feed.currentComments != null)
                      Text(
                        widget.feed.currentComments ?? "0",
                        style: r16.copyWith(),
                      ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/share.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyMedium!.color!,
                        BlendMode.srcIn,
                      ),
                    ),

                    SizedBox(width: 5),
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
                    style: r12.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    height: 15,
                    width: 15,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.grey,
                      BlendMode.srcIn, // Most common for solid coloring
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

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
            itemCount: widget.feed.postImage!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => ImageViewerWidget(
                      imageUrl: widget.feed.postImage![index],
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.feed.postImage![index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes!)
                                  : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image));
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        if (widget.feed.postImage!.length > 1)
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.feed.postImage!.length, (index) {
                bool isActive = index == currentPage.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 4,
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
  }
}
