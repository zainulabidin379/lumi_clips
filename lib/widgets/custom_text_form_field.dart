import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/exports.dart';

class CustomTextField extends StatelessWidget {
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
  final int? minLines;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final double? bottomPadding;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
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
    this.minLines,
    this.bottomPadding,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 20),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.kPrimary,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        readOnly: readOnly ?? false,
        maxLength: maxLength,
        maxLines: null,
        minLines: minLines,
        inputFormatters: inputFormatters,
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
          suffixIcon: trailingIcon,
          prefixIcon: leadingIcon,
        ),
      ),
    );
  }
}
