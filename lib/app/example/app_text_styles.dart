import 'package:flutter/cupertino.dart';

class AppTextStyles {
  //Merri Weather Font Family
  static const String merriWeatherFontFamily = 'MerriWeather';

  //Mulish Font Family
  static const String robotoFontFamily = 'Roboto';

  //Headings
  static TextStyle titleLarge = const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: robotoFontFamily, letterSpacing: 0.4);

  static TextStyle titleMedium = const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, fontFamily: merriWeatherFontFamily, letterSpacing: 0.32);
  static TextStyle titleSmall = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: robotoFontFamily, letterSpacing: 0.28);

  //Body
  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w900, fontFamily: merriWeatherFontFamily, letterSpacing: 0.02);
  static TextStyle bodyMedium = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: robotoFontFamily, letterSpacing: 0.24);

  static TextStyle bodySmall = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: robotoFontFamily, letterSpacing: 0.24);
}
