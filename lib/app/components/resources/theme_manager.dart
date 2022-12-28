import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3g_chat/app/components/resources/styles_manager.dart';
import 'package:m3g_chat/app/components/resources/values_manager.dart';

import 'color_manager.dart';
import 'fonts_manager.dart';

ThemeData getLightApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primarySwatch: Colors.green,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.primary,
    splashColor: ColorManager.lightPrimary,
    fontFamily: FontConstants.fontFamily,

    // cardView theme
    cardTheme: const CardTheme(
      color: ColorManager.light,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s0,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        color: ColorManager.light,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    // Bottom Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.light,
          fontSize: FontSize.s17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge: getExtraBoldStyle(
        color: ColorManager.darkPrimary,
      ),
      displayMedium: getLightStyle(
        color: ColorManager.lightPrimary,
      ),
      headlineLarge: getExtraBoldStyle(
        color: ColorManager.darkGrey,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.lightGrey,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),

    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(
        AppPadding.p2,
      ),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),

      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      // focused border style
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}

ThemeData getDarkApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primarySwatch: Colors.orange,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.primary,
    splashColor: ColorManager.lightPrimary,
    fontFamily: FontConstants.fontFamily,

    // cardView theme
    cardTheme: const CardTheme(
      color: ColorManager.light,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s0,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.light,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    // Bottom Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.light,
          fontSize: FontSize.s17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge: getExtraBoldStyle(
        color: ColorManager.darkPrimary,
        fontSize: FontSize.s22,
      ),
      displayMedium: getLightStyle(
        color: ColorManager.lightPrimary,
      ),
      headlineLarge: getExtraBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
          color: ColorManager.primary /* fontSize: FontSize.s14*/),
      bodyLarge: getRegularStyle(color: ColorManager.lightGrey),
      bodySmall: getRegularStyle(color: ColorManager.grey),
    ),

    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(
        AppPadding.p2,
      ),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),

      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      // focused border style
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
