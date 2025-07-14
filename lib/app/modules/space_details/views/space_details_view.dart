import 'package:Intellio/app/widgets/feed_tile.widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../feed/controllers/feed_controller.dart';
import '../controllers/space_details_controller.dart';

class SpaceDetailsView extends GetView<SpaceDetailsController> {
  const SpaceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Get.put(FeedController());
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              scrolledUnderElevation: 0,
              title: Text(
                "Untitled",
                style: r20.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SliverAppBar(
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: feedController.feeds.value.length,
                  (context, index) {
                    return FeedTileWidget(feed: feedController.feeds[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
