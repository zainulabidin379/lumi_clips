import 'package:flutter/material.dart';

import '../exports.dart';

class AppTextStyle {
  /// 22 - White - Bold
  static const TextStyle kHeadingLarge = TextStyle(
    fontSize: 22,
    color: AppColors.kBlack,
    fontFamily: AppFonts.bold,
  );

  /// 18 - White - Bold
  static const TextStyle kHeadingText = TextStyle(
    fontSize: 18,
    color: AppColors.kBlack,
    fontFamily: AppFonts.bold,
  );

  /// 18 - White - Regular
  static const TextStyle kLargeBodyText = TextStyle(
    fontSize: 18,
    color: AppColors.kBlack,
    fontFamily: AppFonts.regular,
  );

  /// 16 - White - Regular
  static const TextStyle kMediumBodyText = TextStyle(
    fontSize: 16,
    color: AppColors.kBlack,
    fontFamily: AppFonts.regular,
  );

  /// 14 - White - Regular
  static const TextStyle kDefaultBodyText = TextStyle(
    fontSize: 14,
    color: AppColors.kBlack,
    fontFamily: AppFonts.regular,
  );

  /// 12 - White - Regular
  static const TextStyle kSmallBodyText = TextStyle(
    fontSize: 12,
    color: AppColors.kBlack,
    fontFamily: AppFonts.regular,
  );

  /// 10 - White - Regular
  static const TextStyle kVerySmallBodyText = TextStyle(
    fontSize: 10,
    color: AppColors.kBlack,
    fontFamily: AppFonts.regular,
  );
}
