import 'package:flutter/material.dart';

/// app bar for settinngs page and permissions page
class CustomMiniAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool centerTitle;
  final bool showLeading;
  final Widget? leading;

  const CustomMiniAppBar({
    super.key,
    required this.title,
    this.height = 100,
    this.centerTitle = true,
    this.showLeading = false,
    this.leading,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: showLeading,
      scrolledUnderElevation: 1, // can be 0
      toolbarHeight: height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1, // Ensuring proper text alignment
        ),
      ),
    );
  }
}
