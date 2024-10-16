import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color mainBlack = Color(0xff272c30);
  static const Color darkGrey = Color(0xff585858);
  static const Color lightColor = Color(0xFFF6F6F6);
  static const Color regularGrey = Color(0xffAFAFAF);
  static const Color lightGrey = Color(0xffEFF1F4);
  static const Color mainColor = Color(0xff000000);
  static const Color darkerMainColor = Color(0xff555555);
  static const Color oldMainColor = Color(0xffFda318);
  // static const Color darkerMainColor = Color(0xfff0a000);
  static const Color red = Color(0xffCD0013);
  static const Color error = Color(0xFFAB2A0E);
  static const Color darkHeader = Color(0xFF081121);
  static const Color darkBlue = Color(0xff0B182E);


}

MaterialColor convertToMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;
  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
