import 'package:flutter/material.dart';

import '../resources/res.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.height = 45,
    this.width = 100,
    this.fontSize = 16,
    this.buttonColor = AppColors.kPrimary,
    this.textColor = AppColors.kWhite,
    required this.title,
    this.icon,
    required this.onPress,
    this.borderSide = BorderSide.none,
    this.fontFamily = AppFonts.semibold,
    this.borderRadius = 50,
  });
  final IconData? icon;
  final String title;
  final double? height, width, fontSize;
  final Color? textColor, buttonColor;
  final void Function()? onPress;
  final BorderSide borderSide;
  final String? fontFamily;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              side: borderSide),
        ),
        onPressed: onPress,
        child: (icon != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: textColor,
                    size: fontSize,
                  ),
                  Visibility(
                    visible: title.isNotEmpty,
                    child: Text(
                      title,
                      style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
                    ),
                  )
                ],
              )
            : Text(
                title,
                style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
              ),
      ),
    );
  }
}
