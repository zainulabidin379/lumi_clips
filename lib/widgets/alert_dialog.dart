import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumi_clips/widgets/custom_text_button.dart';

import '../helpers/exports.dart';

void showAlertDialog(
    {required BuildContext context,
    required String title,
    required Widget body,
    required Function()? onSave,
    bool? barrierDismissible,
    bool? showSaveButton,
    Color? saveButtonColor,
    String? saveButtonTitle,
    String? cancelButtonTitle}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      surfaceTintColor: AppColors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          context.h(2).heightBox,
          Text(
            title,
            style: AppTextStyle.kLargeBodyText.copyWith(
              fontFamily: AppFonts.bold,
              color: AppColors.kPrimary,
            ),
          ).padHrz(15),
          ListView(
            shrinkWrap: true,
            children: [
              context.h(2).heightBox,
              // Body Widget
              body.padHrz(15),
              context.h(2).heightBox,
            ],
          ).flexible,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                onPressed: () {
                  Get.close(1);
                },
                text: cancelButtonTitle ?? 'Cancel',
                fontFamily: AppFonts.medium,
                color: AppColors.kGrey,
              ),
              Visibility(
                visible: showSaveButton ?? true,
                child: CustomTextButton(
                  onPressed: onSave,
                  text: saveButtonTitle ?? 'Save',
                  color: saveButtonColor ?? AppColors.kPrimary,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ],
          ).padRight(15),
          context.h(1).heightBox,
        ],
      ),
    ).unFocus(context),
  );
}
