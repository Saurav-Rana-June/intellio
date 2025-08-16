import 'package:Intellio/app/widgets/appbar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../widgets/fields/custom_form_field.dart';
import '../controllers/search_controller.dart' as search;

class SearchView extends GetView<search.SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appBarTitle: "Search"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CustomFormField(
              controller: TextEditingController(),
              hintText: 'Search for spaces...',
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),

            buildFallbackText(),
          ],
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
              'assets/icons/search.svg',
              height: 50,
              width: 50,
              colorFilter: ColorFilter.mode(
                regular50,
                BlendMode.srcIn, // Most common for solid coloring
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Notice: currently this feature is not available due to technical limitations.",
              style: r14.copyWith(color: regular50),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
