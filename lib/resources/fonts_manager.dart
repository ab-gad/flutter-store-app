import 'package:flutter/material.dart';

abstract class FontConstants {
  // Font Families
  static const fontFamily = "Montserrat";

  // Font Weights
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;

  // Font Sizes
  static const s10 = 10.0;
  static const s12 = 12.0;
  static const s14 = 14.0;
  static const s16 = 16.0;
  static const s18 = 18.0;
  static const s17 = 18.0;
  static const s20 = 20.0;
}

enum AppFontWeights {
  light,
  regular,
  medium,
  semibold,
  bold,
}

extension AppFontWeightsEnumValues on AppFontWeights {
  FontWeight get value {
    return switch (this) {
      AppFontWeights.light => FontConstants.light,
      AppFontWeights.regular => FontConstants.regular,
      AppFontWeights.medium => FontConstants.medium,
      AppFontWeights.semibold => FontConstants.semiBold,
      AppFontWeights.bold => FontConstants.bold,
    };
  }
}

enum AppFontSizes {
  s12,
  s10,
  s14,
  s16,
  s17,
  s18,
  s20,
}

extension AppFontSizesEnumValues on AppFontSizes {
  double get value {
    return switch (this) {
      AppFontSizes.s10 => FontConstants.s10,
      AppFontSizes.s12 => FontConstants.s12,
      AppFontSizes.s14 => FontConstants.s14,
      AppFontSizes.s16 => FontConstants.s16,
      AppFontSizes.s17 => FontConstants.s17,
      AppFontSizes.s18 => FontConstants.s18,
      AppFontSizes.s20 => FontConstants.s20,
    };
  }
}

enum AppFontFamilies {
  montserrat,
}

extension AppFontFamiliesEnumValues on AppFontFamilies {
  String get value => switch (this) {
        AppFontFamilies.montserrat => FontConstants.fontFamily,
      };
}
