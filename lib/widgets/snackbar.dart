import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/exports.dart';

class ShowSnackbar {
  static message(String msg) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: AppColors.kLightBlue,
      messageText: Text(
        msg,
        style: AppTextStyle.kMediumBodyText
            .copyWith(color: AppColors.kWhite, fontFamily: AppFonts.medium),
      ),
      padding: 15.padAll(),
      margin: 15.padAll(),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.up,
      animationDuration: Durations.long4,
      duration: const Duration(seconds: 4),
      borderRadius: 15,
    ));
  }

  static success(String msg) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: AppColors.kPrimary,
      messageText: Text(
        msg,
        style: AppTextStyle.kMediumBodyText
            .copyWith(color: AppColors.kWhite, fontFamily: AppFonts.medium),
      ),
      padding: 15.padAll(),
      margin: 15.padAll(),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.up,
      animationDuration: Durations.long4,
      duration: const Duration(seconds: 4),
      borderRadius: 15,
    ));
  }

  static error(String msg) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: AppColors.kRed,
      messageText: Text(
        msg,
        style: AppTextStyle.kMediumBodyText
            .copyWith(color: AppColors.kWhite, fontFamily: AppFonts.medium),
      ),
      padding: 15.padAll(),
      margin: 15.padAll(),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.up,
      animationDuration: Durations.long4,
      duration: const Duration(seconds: 4),
      borderRadius: 15,
    ));
  }
}
