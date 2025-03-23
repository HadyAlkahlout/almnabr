import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey1,

    // Ripple color
    splashColor: ColorManager.primaryOpacity70,

    // Card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: AppSize.s4,
      titleTextStyle: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        textStyle: getRegularStyle(color: ColorManager.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        disabledBackgroundColor: ColorManager.grey
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      headlineLarge: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s40,
      ),
      headlineMedium: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s38,
      ),
      headlineSmall: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
      ),
      titleLarge: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s30,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s14,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s12,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s10,
      ),
      labelSmall: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s14,
      ),
    ),

    // Input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRegularStyle(color: ColorManager.grey1),

      // label style
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      // error style
      errorStyle: getRegularStyle(color: ColorManager.error),

      // focused border
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      ),

      // error border
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
      ),

      // focused error border
      focusedErrorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      ),
    ),
  );
}
