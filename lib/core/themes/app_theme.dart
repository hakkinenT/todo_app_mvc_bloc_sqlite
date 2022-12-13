import 'package:flutter/material.dart';

import 'color/app_color_palette.dart';

class TodoThemeData {
  static final lightTheme = AppThemeData.themeData(
      colorScheme: lightColorScheme,
      textTheme: ThemeData.light().textTheme,
      backgroundSnackBar: AppColorPalette.successColorLight);

  static final darkTheme = AppThemeData.themeData(
      colorScheme: darkColorScheme,
      textTheme: ThemeData.dark().textTheme,
      backgroundSnackBar: AppColorPalette.successColorDark);

  static ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColorPalette.lightColors.primary,
      onPrimary: AppColorPalette.lightColors.onPrimary,
      secondary: AppColorPalette.lightColors.secondary,
      onSecondary: AppColorPalette.lightColors.onSecondary,
      error: AppColorPalette.lightColors.error,
      onError: AppColorPalette.lightColors.onError,
      background: AppColorPalette.lightColors.background,
      onBackground: AppColorPalette.lightColors.onBackground,
      surface: AppColorPalette.lightColors.surface,
      onSurface: AppColorPalette.lightColors.onSurface);

  static ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColorPalette.darkColors.primary,
      onPrimary: AppColorPalette.darkColors.onPrimary,
      secondary: AppColorPalette.darkColors.secondary,
      onSecondary: AppColorPalette.darkColors.onSecondary,
      error: AppColorPalette.darkColors.error,
      onError: AppColorPalette.darkColors.onError,
      background: AppColorPalette.darkColors.background,
      onBackground: AppColorPalette.darkColors.onBackground,
      surface: AppColorPalette.darkColors.surface,
      onSurface: AppColorPalette.darkColors.onSurface);
}

class AppThemeData {
  static ThemeData themeData(
          {required ColorScheme colorScheme,
          required TextTheme textTheme,
          required Color? backgroundSnackBar}) =>
      ThemeData(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.background,
          textSelectionTheme: getTextSelectionThemeData(colorScheme),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: getElevatedButtonStyle(colorScheme)),
          switchTheme: getSwitchThemeData(colorScheme),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: getOutlinedButtonStyle(colorScheme)),
          textButtonTheme:
              TextButtonThemeData(style: getTextButtonStyle(colorScheme)),
          inputDecorationTheme: getInputDecorationTheme(colorScheme),
          appBarTheme: getAppBarTheme(colorScheme),
          iconTheme: getIconThemeData(colorScheme),
          canvasColor: colorScheme.background,
          textTheme: getTextTheme(textTheme),
          progressIndicatorTheme: getProgressIndicatorThemeData(colorScheme),
          cardTheme: getCardTheme(colorScheme),
          snackBarTheme: getSnackBarThemeData(backgroundSnackBar),
          checkboxTheme: getCheckboxThemeData(colorScheme));

  static ProgressIndicatorThemeData getProgressIndicatorThemeData(
          ColorScheme colorScheme) =>
      ProgressIndicatorThemeData(color: colorScheme.secondary);

  static SnackBarThemeData getSnackBarThemeData(Color? background) =>
      SnackBarThemeData(
        backgroundColor: background,
        actionTextColor: const Color(0xFF036108),
        contentTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        behavior: SnackBarBehavior.floating,
      );

  static CardTheme getCardTheme(ColorScheme colorScheme) => CardTheme(
      margin: const EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.onPrimary.withOpacity(0.1)),
        borderRadius: const BorderRadius.all(Radius.zero),
      ));

  static ListTileThemeData getListTileThemeData(ColorScheme colorScheme) =>
      ListTileThemeData(
        iconColor: colorScheme.secondary,
      );

  static TextSelectionThemeData getTextSelectionThemeData(
          ColorScheme colorScheme) =>
      TextSelectionThemeData(
          cursorColor: colorScheme.secondary,
          selectionColor: colorScheme.secondary.withOpacity(0.3),
          selectionHandleColor: colorScheme.secondary.withOpacity(0.8));

  static IconThemeData getIconThemeData(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onPrimary);

  static AppBarTheme getAppBarTheme(ColorScheme colorScheme) => AppBarTheme(
      backgroundColor: colorScheme.primary,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      elevation: 1);

  static ButtonStyle getElevatedButtonStyle(ColorScheme colorScheme) =>
      ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));

  static TextTheme getTextTheme(TextTheme base) {
    return base.copyWith(
        button: base.button!.copyWith(
            letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 16));
  }

  static ButtonStyle getOutlinedButtonStyle(ColorScheme colorScheme) =>
      OutlinedButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          side: BorderSide(color: colorScheme.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ));

  static ButtonStyle getTextButtonStyle(ColorScheme colorScheme) =>
      TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          textStyle: const TextStyle(letterSpacing: 0, fontSize: 14));

  static InputDecorationTheme getInputDecorationTheme(
          ColorScheme colorScheme) =>
      InputDecorationTheme(
          focusColor: colorScheme.secondary.withOpacity(0.5),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(color: colorScheme.onPrimary.withOpacity(0.5)),
          labelStyle: TextStyle(fontSize: 16, color: colorScheme.secondary),
          suffixIconColor: colorScheme.secondary,
          filled: true,
          fillColor: colorScheme.primary.withOpacity(0.84),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: colorScheme.secondary.withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colorScheme.secondary)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colorScheme.error)));

  static CheckboxThemeData getCheckboxThemeData(ColorScheme colorScheme) =>
      CheckboxThemeData(
          checkColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }

        return null;
      }), fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme.secondary;
        }

        return null;
      }));

  static SwitchThemeData getSwitchThemeData(ColorScheme colorScheme) =>
      SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme.secondary;
        }

        return null;
      }), trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme.secondary.withOpacity(0.3);
        }

        return null;
      }));
}
