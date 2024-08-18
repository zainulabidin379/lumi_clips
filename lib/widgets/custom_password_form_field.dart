import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers/exports.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final double? hintTextSize;
  final Color? hintTextColor;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final double? textFieldRadius;
  final int? maxLength;
  final bool? readOnly;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final Color? errorBorderColor;
  final Color? enabledBorderColor;
  final Color? focusBorderColor;
  final Function()? onTap;
  final String? fieldLabel;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextSize,
    this.hintTextColor,
    this.textInputType,
    this.textFieldRadius,
    this.leadingIcon,
    this.trailingIcon,
    this.readOnly,
    this.errorBorderColor,
    this.focusBorderColor,
    this.enabledBorderColor,
    this.onTap,
    this.fieldLabel,
    this.validator,
    required this.label,
    this.textInputAction,
    this.maxLength,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    final RxBool obscureText = true.obs;

    void toggle() {
      obscureText.value = !obscureText.value;
    }

    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.kPrimary,
          keyboardType: textInputType,
          obscureText: obscureText.value,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          readOnly: readOnly ?? false,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
          onTap: onTap,
          style: AppTextStyle.kLargeBodyText.copyWith(fontFamily: AppFonts.semibold),
          validator: validator,
          decoration: InputDecoration(
            label: Text(
              label,
            ),
            labelStyle: AppTextStyle.kLargeBodyText.copyWith(fontFamily: AppFonts.medium, color: AppColors.kPrimary),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            hintStyle: AppTextStyle.kDefaultBodyText.copyWith(color: AppColors.kGrey),
            prefixIcon: leadingIcon,
            suffixIcon: IconButton(
              onPressed: toggle,
              icon: Icon(
                obscureText.value ? Icons.visibility : Icons.visibility_off,
                color: AppColors.kGrey,
              ),
            ),
          ),
        ),
      );
    });
  }
}
