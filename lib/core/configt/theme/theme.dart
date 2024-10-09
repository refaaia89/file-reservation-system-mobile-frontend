import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
      primaryColor: Colors.black45,
      primaryColorLight: Colors.black45,
      primaryColorDark: Colors.black45,
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Colors.black45,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black45,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: MaterialStateProperty.all(const Color(0xff303030)),
      )),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.black45),
      splashColor: Colors.lightBlueAccent,
      inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.black)));

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.black12,
    primaryColorDark: Colors.black45,
    iconTheme: const IconThemeData(color: Colors.white),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.amber.shade900.withAlpha(200),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[900],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.black45),
    scaffoldBackgroundColor: const Color(0xff303030),
    splashColor: const Color(0xff303030),
  );
}
