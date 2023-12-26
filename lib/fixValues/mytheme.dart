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
            titleMedium: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white))
        .apply(bodyColor: Colors.white),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        )),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: AppColor.secondary,
      suffixIconColor: AppColor.secondary,
      prefixIconColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 4, color: AppColor.secondary),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.white),
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
