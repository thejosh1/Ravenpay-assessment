import 'package:flutter/material.dart';
import 'package:ravenpay_assessment/core/res/fonts.dart';

enum AppTheme {
  lightTheme,
  darkTheme
}

final appThemeData = {
  AppTheme.lightTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    fontFamily: Fonts.satoshi,
  ),

  AppTheme.darkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    fontFamily: Fonts.satoshi,
  ),
};
