import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWithBack extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithBack({super.key, this.action});

  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        child: SvgPicture.asset(AppImages.back),
        onTap: () {
          pop(context);
        },
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
