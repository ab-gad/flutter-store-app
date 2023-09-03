import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'fonts_manager.dart';

class TextStyleManager {
  static const defaultFontFamily = AppFontFamilies.montserrat;
  static const defaultFontSize = AppFontSizes.s14;
  static const defaultFontWeight = AppFontWeights.regular;
  static const defaultFontColor = AppColors.darkGrey;

  static TextStyle _buildTextStyle({
    AppFontFamilies? fontFamily,
    AppFontSizes? fontSize,
    AppFontWeights? fontWeight,
    AppColors? fontColor,
  }) {
    return TextStyle(
      fontFamily:
          fontFamily != null ? fontFamily.value : defaultFontFamily.value,
      fontSize: fontSize != null ? fontSize.value : defaultFontSize.value,
      fontWeight:
          fontWeight != null ? fontWeight.value : defaultFontWeight.value,
      color: fontColor != null ? fontColor.value : defaultFontColor.value,
    );
  }

  static TextStyle boldTextStyle({
    AppFontSizes? fontSize,
    AppColors? fontColor,
    AppFontFamilies? fontFamily,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: AppFontWeights.bold,
    );
  }

  static TextStyle lightTextStyle({
    AppFontSizes? fontSize,
    AppColors? fontColor,
    AppFontFamilies? fontFamily,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: AppFontWeights.light,
    );
  }

  static TextStyle regularTextStyle({
    AppFontSizes? fontSize,
    AppColors? fontColor,
    AppFontFamilies? fontFamily,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: AppFontWeights.regular,
    );
  }

  static TextStyle semiBoldTextStyle({
    AppFontSizes? fontSize,
    AppColors? fontColor,
    AppFontFamilies? fontFamily,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: AppFontWeights.semibold,
    );
  }

  static TextStyle mediumTextStyle({
    AppFontSizes? fontSize,
    AppColors? fontColor,
    AppFontFamilies? fontFamily,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontFamily: fontFamily,
      fontWeight: AppFontWeights.medium,
    );
  }
}
