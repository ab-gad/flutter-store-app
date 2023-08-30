import 'package:flutter/material.dart';

abstract class ColorManager {
  // Primary Orange
  static Color darkPrimary = const Color(0xffd17d11);
  static Color lightPrimary = const Color(0xCCd17d11); // color with 80% opacity
  static Color primary = const Color(0xffED9728);

  // gray
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xff9E9E9E);

  // // new colors
  // static Color grey1 = const Color(0xff707070);
  // static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34); // red color
}

// This extension is not used because of
// - using it prevent us from using const Color constructor and prevent us
// from seeing the colors that we use
extension HexColor on Color {
  ///
  /// Method to convert the hexa colors string into  a [Color] object
  ///
  /// Because hexa colors can come with or without opacity we need to
  /// 1. validate over the length of the coming hexa
  /// 2. convert it into a parsable string by removing the "#" and adding
  /// the opacity values
  /// 3. return the color of the integer of the parsed string
  ///
  /// #### Note:
  /// To parse a hexa string into an integer u need to specify the [radix]
  /// param `int.parse('hexaString', radix: 16)`
  /// but by prefixing the string with "0x" the constructor knows its a hexa int
  /// what u want
  ///
  static Color fromHexa(String hexaColor) {
    String readyToParseString;
    if (hexaColor.length == 6) {
      readyToParseString = hexaColor.replaceAll('#', '0xFF');
    } else {
      readyToParseString = hexaColor.replaceAll('#', '0x');
    }
    return Color(int.parse(readyToParseString));
  }
}

enum AppColors {
  darkPrimary,
  lightPrimary,
  primary,
  darkGrey,
  grey,
  lightGrey,
  white,
  error,
}

extension AppColorsEnumValues on AppColors {
  Color get value => switch (this) {
        AppColors.darkPrimary => ColorManager.darkPrimary,
        AppColors.lightPrimary => ColorManager.lightPrimary,
        AppColors.primary => ColorManager.primary,
        AppColors.darkGrey => ColorManager.darkGrey,
        AppColors.grey => ColorManager.grey,
        AppColors.lightGrey => ColorManager.lightGrey,
        AppColors.white => ColorManager.white,
        AppColors.error => ColorManager.error,
      };
}
