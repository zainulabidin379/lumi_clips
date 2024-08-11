import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/exports.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.fontSize = 14,
    required this.onPressed,
    this.color,
    this.fontFamily = AppFonts.regular,
  });

  final String text;
  final double? fontSize;
  final void Function()? onPressed;
  final Color? color;
  final String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        surfaceTintColor: AppColors.transparent,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color??context.theme.primaryColor,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
