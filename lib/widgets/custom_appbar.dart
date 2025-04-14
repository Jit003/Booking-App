import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class BhadraneeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      elevation: 0,
      centerTitle: false,
      title: Image.asset(
        'assets/images/logo.png',
        height: 100,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 25),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }
}
