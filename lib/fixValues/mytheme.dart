import 'package:flutter/material.dart';
import 'package:pwsafe/fixValues/mycolor.dart';

ThemeData myTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.background,
    canvasColor: AppColor.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.background,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
            subtitle1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white))
        .apply(bodyColor: Colors.white),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondary)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: AppColor.secondary,
      suffixIconColor: AppColor.secondary,
      prefixIconColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 32,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      hintStyle: TextStyle(color: Colors.white),
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColor.secondary,
        actionTextColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)))),
  );
}