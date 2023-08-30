import 'package:flutter/material.dart';
import 'package:flutter_store_app/presentation/color_manager.dart';
import 'package:flutter_store_app/presentation/fonts_manager.dart';
import 'package:flutter_store_app/presentation/style_manager.dart';
import 'package:flutter_store_app/presentation/values_manager.dart';

abstract class ThemeManager {
  static const defaultElevation = AppValues.v4;
  static final defaultShadowColor = ColorManager.grey;

  static ThemeData getAppTheme() {
    return ThemeData(
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey,
      splashColor: ColorManager.lightPrimary,

      // Card theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: defaultElevation,
        shadowColor: defaultShadowColor,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: defaultElevation,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle: TextStyleManager.semiBoldTextStyle(
          fontColor: AppColors.white,
          fontSize: AppFontSizes.s16,
        ),
      ),

      // Button theme
      buttonTheme: ButtonThemeData(
          splashColor: ColorManager.lightPrimary,
          buttonColor: ColorManager.primary,
          disabledColor: ColorManager.grey,
          shape: const StadiumBorder()),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          textStyle: TextStyleManager.regularTextStyle(
              fontColor: AppColors.white, fontSize: AppFontSizes.s18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.v12),
          ),
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayMedium:
            TextStyleManager.lightTextStyle(fontSize: AppFontSizes.s20),
        headlineMedium:
            TextStyleManager.semiBoldTextStyle(fontSize: AppFontSizes.s18),
        bodyMedium: TextStyleManager.regularTextStyle(),
        bodySmall:
            TextStyleManager.regularTextStyle(fontSize: AppFontSizes.s12),
        bodyLarge:
            TextStyleManager.regularTextStyle(fontSize: AppFontSizes.s16),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppValues.v8),

        // Input text states
        hintStyle: TextStyleManager.regularTextStyle(fontColor: AppColors.grey),
        labelStyle: TextStyleManager.mediumTextStyle(fontColor: AppColors.grey),
        errorStyle:
            TextStyleManager.regularTextStyle(fontColor: AppColors.error),

        // Input border states
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.grey,
            width: AppValues.v1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppValues.v8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.black,
            width: AppValues.v1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppValues.v8),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.errorLight,
            width: AppValues.v1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppValues.v8),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.error,
            width: AppValues.v1_5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppValues.v8),
          ),
        ),
      ),
    );
  }
}
