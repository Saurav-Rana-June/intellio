import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/feed_tile.widget.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Get.put(FeedController());

    return Scaffold(
      appBar: AppbarWidget(),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: feedController.feeds.value.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FeedTileWidget(feed: feedController.feeds[index]);
          },
        ),
      ),
    );
  }
}
