import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../infrastructure/theme/theme.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  String? appBarTitle;

  AppbarWidget({super.key, this.appBarTitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: primary, // shadow color
              offset: Offset(0, 7), // horizontal: 0, vertical: 3 (bottom)
              blurRadius: 5, // softens the shadow
              spreadRadius: -10, // optional
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    height: 25,
                    width: 25,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn, // Most common for solid coloring
                    ),
                  ),
                ),
                SizedBox(width: 15),

                appBarTitle != null
                    ? Text(
                      appBarTitle ?? "Untitled",
                      style: r20.copyWith(fontWeight: FontWeight.w600),
                    )
                    : SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 25,
                      height: 25,
                      colorFilter:
                          Theme.of(context).brightness == Brightness.dark
                              ? ColorFilter.mode(white, BlendMode.srcIn)
                              : null,
                    ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/settings.svg',
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyMedium!.color!,
                  BlendMode.srcIn, // Most common for solid coloring
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
