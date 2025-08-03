import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:Intellio/app/widgets/loader.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import '../../../widgets/feed_tile.widget.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.delete<FeedController>();
    final feedController = Get.put(FeedController());

    return Scaffold(
      appBar: AppbarWidget(),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(
          () =>
              feedController.isLoading.value
                  ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Loader(colors: [primary, primary, primary]),
                      ],
                    ),
                  )
                  : feedController.feeds != null &&
                      feedController.feeds.isNotEmpty
                  ? ListView.builder(
                    itemCount: feedController.feeds.value.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FeedTileWidget(feed: feedController.feeds[index]);
                    },
                  )
                  : buildFallbackText(),
        ),
      ),
    );
  }

  Expanded buildFallbackText() {
    return Expanded(
      child: Container(
        width: Get.width,
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
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Oops! currently there aren't any feeds...",
              style: r14.copyWith(color: regular50),
            ),
          ],
        ),
      ),
    );
  }
}
