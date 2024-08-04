import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../resources/res.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.color, this.size, this.text, this.textColor});
  final double? size;
  final Color? color;
  final String? text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpinKitCircle(
          color: color ?? AppColors.kPrimary,
          size: size ?? 40,
        ),
        text != null
            ? Text(
                text!,
                style: TextStyle(color: textColor ?? AppColors.kBlack.withOpacity(0.7)),
              )
            : const SizedBox(),
      ],
    );
  }
}

void loadingDialog(String? text) async {
  return Get.dialog(
      PopScope(
        canPop: false,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.kSecondary, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              text != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          text,
                          style: TextStyle(
                            color: AppColors.kWhite.withOpacity(0.9),
                            fontSize: Get.height / 55,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                width: 150,
                child: SpinKitCircle(
                  color: AppColors.kPrimary,
                  size: 40,
                ),
              ),
            ],
          ),
        ).center,
      ),
      barrierDismissible: false,
      barrierColor: AppColors.kBlack.withOpacity(0.5));
}
