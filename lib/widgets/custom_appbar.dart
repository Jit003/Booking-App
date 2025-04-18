import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_images.dart';

class BhadraneeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.bgColor,
      elevation: 1,
      centerTitle: false,
      title: Image.asset(
        AppImages.appBarlogo,
        height: 100,
      ),
    );
  }
}
