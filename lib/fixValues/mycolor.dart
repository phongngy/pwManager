import 'package:flutter/material.dart';

class AppColor {
  static const Color background = Color(0xFFE5DB9C);

  static const Color lila = Color(0xFFBEB4C5);
  static const Color hellbraun = Color(0xFFD0BCAC);
  static const Color orange = Color(0xFFE6A57E);
  static const Color pink = Color(0xFFF5BFD2);

  static Color colorFinden(String farbe) {
    switch (farbe) {
      case "Color(0xfff5bfd2)":
        return pink;
      case "Color(0xffd0bcac)":
        return hellbraun;
      case "Color(0xffbeb4c5)":
        return lila;
      case "Color(0xffe6a57e)":
        return orange;
      default:
        throw Exception("Gesuchte Farbe nicht gefunden");
    }
  }

  static String colorHexCodeString(String farbe) {
    switch (farbe) {
      case "pink":
        return "Color(0xfff5bfd2)";
      case "hellbraun":
        return "Color(0xffd0bcac)";
      case "lila":
        return "Color(0xffbeb4c5)";
      case "orange":
        return "Color(0xffe6a57e)";
      default:
        throw Exception("Gesuchte Farbe nicht gefunden");
    }
  }

  static String colorAlsName(String farbe) {
    switch (farbe) {
      case "Color(0xfff5bfd2)":
        return "pink";
      case "Color(0xffd0bcac)":
        return "hellbraun";
      case "Color(0xffbeb4c5)":
        return "lila";
      case "Color(0xffe6a57e)":
        return "orange";
      default:
        return "";
    }
  }
}
