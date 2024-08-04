import 'package:flutter/material.dart';

import '../resources/res.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.text,
      this.leading,
      this.onTap,
      this.actions,
      this.backgroundColor,
      this.fontFamily,
      this.leadingWidget});
  final String text;
  final bool? leading;
  final Widget? leadingWidget;
  final Function()? onTap;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.kWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: leading ?? true
          ? IconButton(
              onPressed: onTap ??
                  () {
                    context.pop();
                  },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.kSecondary,
                size: 25,
              ))
          : leadingWidget,
      title: Text(
        text,
        style: AppTextStyle.kHeadingText.copyWith(
          color: AppColors.kSecondary,
          fontSize: 28,
          fontFamily: fontFamily ?? AppFonts.bold,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
