import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/appbar.widget.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/spaces_controller.dart';

class SpacesView extends GetView<SpacesController> {
  const SpacesView({super.key});

  @override
  Widget build(BuildContext context) {
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

            buildSpacesGrid(),
          ],
        ),
      ),
    );
  }

  Expanded buildSpacesGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 2.9,
        ),
        itemCount: 10, // Number of items
        itemBuilder: (context, index) {
          return spaceTile();
        },
      ),
    );
  }
}

class spaceTile extends StatelessWidget {
  const spaceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SPACE_DETAILS);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: regular50.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text("Comedy", style: r16.copyWith()),
          ],
        ),
      ),
    );
  }
}
