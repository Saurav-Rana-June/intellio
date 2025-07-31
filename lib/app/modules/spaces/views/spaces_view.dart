import 'package:Intellio/app/modules/spaces/views/add_feed_view.dart';
import 'package:Intellio/app/widgets/loader.dart';
import 'package:Intellio/app/widgets/modals/popup.modal.dart';
import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/appbar.widget.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/spaces_controller.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class SpacesView extends GetView<SpacesController> {
  const SpacesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpacesController());

    return Scaffold(
      appBar: AppbarWidget(appBarTitle: "Your Spaces"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomFormField(
              controller: TextEditingController(),
              hintText: 'Search for your spaces...',
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            Obx(
              () =>
                  controller.loading.value
                      ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Loader(colors: [primary, primary, primary]),
                          ],
                        ),
                      )
                      : buildSpacesGrid(context),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context, controller),
    );
  }

  Padding buildFloatingActionButton(
    BuildContext context,
    SpacesController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: SvgPicture.asset(
              'assets/icons/folder.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                primary,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            labelStyle: r16,
            label: 'Add Space',
            onTap: () {
              buildAddSpaceDialog(
                context,
                controller.spaceTypeToggleController,
              );
            },
          ),
          SpeedDialChild(
            child: SvgPicture.asset(
              'assets/icons/feed_post.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                primary,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            label: 'Add Feed',
            labelStyle: r16,
            onTap: () {
              Get.to(() => AddFeedView());
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildAddSpaceDialog(
    BuildContext context,
    ValueNotifier<bool> _controller,
  ) {
    return showDialog(
      context: context,
      builder:
          (context) => CustomPopupModal(
            title: "Add Space",
            content: IntrinsicHeight(
              child: Container(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text('Space', style: r16.copyWith()),
                      SizedBox(height: 8),
                      CustomFormField(
                        controller: controller.spaceTextController,
                        hintText: 'Name your space',
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Space name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          AdvancedSwitch(
                            controller: _controller,
                            activeColor: primary,
                            inactiveColor: Colors.grey,
                            activeChild: Text('ON'),
                            inactiveChild: Text('OFF'),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(15),
                            ),
                            width: 70.0,
                            height: 30.0,
                            enabled: true,
                            disabledOpacity: 0.5,
                            onChanged: (value) {
                              controller.isPrivate.value = value;
                            },
                          ),
                          SizedBox(width: 16),
                          Text('Private', style: r16.copyWith()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  controller.isPrivate.value = false;
                },
                child: Text('Cancel', style: r16.copyWith(color: primary)),
              ),
              ElevatedButton(
                onPressed: controller.onAddSpace,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primary),
                ),
                child: Text('Add', style: r16.copyWith()),
              ),
            ],
          ),
    );
  }

  Expanded buildSpacesGrid(BuildContext context) {
    return Expanded(
      child:
          controller.spaceModelList != null &&
                  controller.spaceModelList.isNotEmpty
              ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 2.9,
                ),
                itemCount: controller.spaceModelList.length, // Number of items
                itemBuilder: (context, index) {
                  return spaceTile(
                    spaceTitle: controller.spaceModelList[index]!.name,
                    isPrivate: controller.spaceModelList[index]!.isPrivate,
                  );
                },
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/folder.svg',
                    height: 50,
                    width: 50,
                    colorFilter: ColorFilter.mode(
                      regular50,
                      BlendMode.srcIn, // Most common for solid coloring
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Oops! you don't have any space...",
                    style: r14.copyWith(color: regular50),
                  ),
                ],
              ),
    );
  }
}

class spaceTile extends StatelessWidget {
  final String? spaceTitle;
  final bool? isPrivate;
  const spaceTile({
    super.key,
    required this.spaceTitle,
    required this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SPACE_DETAILS);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: regular50.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/folder.svg',
                  height: 22,
                  width: 22,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.bodyMedium!.color!,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 80,
                  child: Text(
                    spaceTitle ?? "--",
                    style: r16.copyWith(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            isPrivate ?? false
                ? SvgPicture.asset(
                  'assets/icons/lock.svg',
                  height: 18,
                  width: 18,
                  colorFilter: ColorFilter.mode(
                    primary,
                    BlendMode.srcIn, // Most common for solid coloring
                  ),
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
