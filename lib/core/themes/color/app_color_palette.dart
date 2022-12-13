import 'package:flutter/material.dart';

class AppColorPaletteDeprecated {
  static const purple600 = Color(0xFF270033);
  static const purple500 = Color(0xFF680089);
  static const purple400 = Color(0xFF740099);
  static const purple300 = Color(0xFFC200FF);
  static const purple200 = Color(0xFFA040BF);
  static const purple100 = Color(0xFFF3CCFF);

  static const white600 = Color(0xFF1A1A1A);
  static const white500 = Color(0xFF4D4D4D);
  static const white400 = Color(0xFF808080);
  static const white300 = Color(0xFFB3B3B3);
  static const white200 = Color(0xFFE6E6E6);
  static const white100 = Color(0xFFFFFFFF);

  static const red600 = Color(0xFF2C0707);
  static const red500 = Color(0xFF851414);
  static const red400 = Color(0xFFB71C1C);
  static const red300 = Color(0xFFDD2222);
  static const red200 = Color(0xFFEB7A7A);
  static const red100 = Color(0xFFF8D3D3);

  static const green600 = Color(0xFF062D07);
  static const green500 = Color(0xFF118815);
  static const green400 = Color(0xFF15A519);
  static const green300 = Color(0xFF1DE222);
  static const green200 = Color(0xFF77EE7B);
  static const green100 = Color(0xFFD2F9D3);

  static const blackText400 = Color(0xFF171717);
  static const blackText300 = Color(0xFF686868);
  static const blackText200 = Color(0xFF939393);

  static const whiteText500 = Color.fromRGBO(255, 255, 255, 0.843);
  static const whiteText400 = Color.fromRGBO(255, 255, 255, 0.87);
  static const whiteText300 = Color.fromRGBO(255, 255, 255, 0.6);
  static const whiteText200 = Color.fromRGBO(255, 255, 255, 0.38);

  static const dark00 = Color(0xFF121212);
  static const dark01 = Color(0xFF1E1E1E);
  static const dark02 = Color(0xFF222222);
  static const dark03 = Color(0xFF242424);
  static const dark04 = Color(0xFF272727);
  static const dark06 = Color(0xFF2C2C2C);
  static const dark08 = Color(0xFF2E2E2E);
  static const dark12 = Color(0xFF333333);
  static const dark16 = Color(0xFF343434);
  static const dark24 = Color(0xFF383838);
}

class AppColor {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;

  const AppColor(
      {required this.primary,
      required this.onPrimary,
      required this.secondary,
      required this.onSecondary,
      required this.error,
      required this.onError,
      required this.background,
      required this.onBackground,
      required this.surface,
      required this.onSurface});
}

class AppColorPalette {
  static const lightColors = AppColor(
      primary: Colors.white,
      onPrimary: Color(0xFF171717),
      secondary: Color(0xFF740099),
      onSecondary: Colors.white,
      error: Color(0xFFD80F0F),
      onError: Colors.white,
      background: Color(0xFFEDEDED),
      onBackground: Color(0xFF171717),
      surface: Colors.white,
      onSurface: Color(0xFF171717));

  static const darkColors = AppColor(
      primary: Color(0xFF272727),
      onPrimary: Color.fromRGBO(255, 255, 255, 0.87),
      secondary: Color(0xFFA040BF),
      onSecondary: Colors.black,
      error: Color(0xFFB53232),
      onError: Colors.black,
      background: Color(0xFF121212),
      onBackground: Color.fromRGBO(255, 255, 255, 0.87),
      surface: Color(0xFF272727),
      onSurface: Color.fromRGBO(255, 255, 255, 0.87));

  static const successColorLight = Color(0xFF2DF133);
  static const successColorDark = Color(0xFF6EF273);
}
