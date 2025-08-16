import 'package:Intellio/app/widgets/feed_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../feed/controllers/feed_controller.dart';
import '../controllers/space_details_controller.dart';

class SpaceDetailsView extends StatefulWidget {
  const SpaceDetailsView({super.key});

  @override
  State<SpaceDetailsView> createState() => _SpaceDetailsViewState();
}

class _SpaceDetailsViewState extends State<SpaceDetailsView> {
  final SpaceDetailsController controller = Get.find();
  final FeedController feedController = Get.find();

  @override
  void initState() {
    controller.filterFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              scrolledUnderElevation: 0,
              title: Text(
                controller.spaceName.value.isNotEmpty
                    ? controller.spaceName.value
                    : 'Space Details',
                style: r20.copyWith(fontWeight: FontWeight.w600),
              ),
            ),

            controller.filteredNewFeeds != null &&
                    controller.filteredNewFeeds.isNotEmpty
                ? SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: feedController.feeds.value.length,
                      (context, index) {
                        if (feedController.feeds[index].space?.name ==
                            controller.spaceName.value) {
                          return FeedTileWidget(
                            feed: feedController.feeds[index],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                )
                : SliverToBoxAdapter(child: buildFallbackText()),
          ],
        ),
      ),
    );
  }

  Container buildFallbackText() {
    return Container(
      width: Get.width,
      height: Get.height - 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/feed.svg',
            height: 50,
            width: 50,
            colorFilter: ColorFilter.mode(
              regular50,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Oops! currently there aren't any feeds in ${controller.spaceName.value}...",
            style: r14.copyWith(color: regular50),
          ),
        ],
      ),
    );
  }
}
