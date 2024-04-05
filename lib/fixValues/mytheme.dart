import 'package:flutter/material.dart';
import 'package:pwsafe/fixValues/mycolor.dart';

ThemeData myTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.background,
    canvasColor: AppColor.background,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: AppColor.background,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white, // Farbe des Icons
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ).apply(bodyColor: Colors.white),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.secondary),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
    dialogTheme: const DialogTheme(
      backgroundColor: AppColor.secondary,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors
              .white; // Farbe des Häkchens, wenn die Checkbox ausgewählt ist
        }
        return null; // default
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor
              .secondary; // Hintergrundfarbe der Checkbox, wenn sie ausgewählt ist
        }
        return null; // default
      }),
      side:
          const BorderSide(color: Colors.white), // Umrandungsfarbe der Checkbox
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.secondary,
      foregroundColor: Colors.white, // Farbe des Icons im Button
      elevation: 2, // Schatten des Buttons
      shape: CircleBorder(),
    ),
  );
}
