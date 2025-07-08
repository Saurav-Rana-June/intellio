import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/feed_tile.widget.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(children: [FeedTileWidget(), FeedTileWidget(),]),
        ),
      ),
    );
  }
}
