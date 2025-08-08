import 'package:Intellio/app/data/enums/snackbar_enum.dart';
import 'package:Intellio/app/data/methods/app_methods.dart';
import 'package:Intellio/app/data/methods/datetime_methods.dart';
import 'package:Intellio/app/modules/feed/controllers/feed_controller.dart';
import 'package:Intellio/app/routes/app_pages.dart';
import 'package:Intellio/app/widgets/image_viewer.widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../infrastructure/theme/theme.dart';
import '../data/models/feed_models/feed_model.dart';
import 'package:video_player/video_player.dart';

class FeedTileWidget extends StatefulWidget {
  final FeedTileModel feed;

  FeedTileWidget({super.key, required this.feed});

  @override
  State<FeedTileWidget> createState() => _FeedTileWidgetState();
}

class _FeedTileWidgetState extends State<FeedTileWidget> {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  final controller = Get.put(FeedController());

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
                        widget.feed.space?.isPrivate == true
                            ? Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  height: 14,
                                  width: 14,
                                  colorFilter: ColorFilter.mode(
                                    primary,
                                    BlendMode
                                        .srcIn, // Most common for solid coloring
                                  ),
                                ),
                                SizedBox(width: 4),
                              ],
                            )
                            : SizedBox(),
                        Text(
                          '${widget.feed.space?.name}',
                          style: r16.copyWith(),
                        ),
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
        if (widget.feed.postMedia != null && widget.feed.postMedia!.isNotEmpty)
          buildMediaSection(context),
        if (widget.feed.contentLink != null &&
            widget.feed.contentLink!.isNotEmpty)
          buildLinkSection(),
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

  InkWell buildLinkSection() {
    return InkWell(
      onTap: () async {
        final link = widget.feed.contentLink;
        if (link != null) {
          await launchUrl(
            Uri.parse(link),
            mode: LaunchMode.externalApplication,
          );
        } else {
          AppMethod.snackbar(
            "Unreachable Link",
            "Unable to open link...",
            SnackBarType.ERROR,
          );
        }
      },
      child: Text(
        widget.feed.contentLink ?? "Invalid Link",
        style: r14.copyWith(color: infoColor),
      ),
    );
  }

  Widget buildMediaSection(BuildContext context) {
    // ['Link', 'Video', 'Image', 'Audio', 'PDF', 'Zip Archive']
    switch (widget.feed.feedType) {
      case 'Image':
        return buildImageViewer(context);

      case 'Video':
        return buildVideoViewer();

      case 'Audio':
        return buildAudioListener();

      default:
        return Column();
    }
  }

  Column buildAudioListener() {
    return Column(
      children: [
        Container(
          height: 80,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: regular50.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.feed.postMedia!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Obx(
                    () => IconButton(
                      onPressed: () {
                        controller.playAudio(widget.feed.postMedia![index]);
                      },
                      icon:
                          controller.isAudioLoading.value
                              ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                              : Icon(
                                controller.isPlaying.value
                                    ? Icons.stop_rounded
                                    : Icons.play_arrow,
                              ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primary),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Slider(
                            padding: EdgeInsets.all(0),
                            min: 0,
                            max: controller.duration.value.inSeconds.toDouble(),
                            value:
                                controller.position.value.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await controller.audioPlayer.seek(position);
                              await controller.audioPlayer.resume();
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.formatDuration(
                                  controller.position.value,
                                ),
                                style: r14.copyWith(),
                              ),
                              Text(
                                controller.formatDuration(
                                  controller.duration.value -
                                      controller.position.value,
                                ),
                                style: r14.copyWith(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            onPageChanged: (index) {
              currentPage.value = index;
            },
          ),
        ),
        const SizedBox(height: 8),
        if (widget.feed.postMedia!.length > 1)
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.feed.postMedia!.length, (index) {
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

  Column buildVideoViewer() {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.feed.postMedia!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Chewie(
                    controller: ChewieController(
                      videoPlayerController: VideoPlayerController.networkUrl(
                        Uri.parse(widget.feed.postMedia![index]),
                      ),
                      autoPlay: true,
                      looping: false,
                    ),
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              currentPage.value = index;
            },
          ),
        ),
        const SizedBox(height: 8),
        if (widget.feed.postMedia!.length > 1)
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.feed.postMedia!.length, (index) {
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

  Column buildImageViewer(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.feed.postMedia!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => ImageViewerWidget(
                      imageUrl: widget.feed.postMedia![index],
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.feed.postMedia![index],
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
                                      loadingProgress.expectedTotalBytes!
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
            onPageChanged: (index) {
              currentPage.value = index;
            },
          ),
        ),
        const SizedBox(height: 8),
        if (widget.feed.postMedia!.length > 1)
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.feed.postMedia!.length, (index) {
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
