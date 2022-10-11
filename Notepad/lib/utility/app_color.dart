import 'package:flutter/material.dart';

class AppColor {

  ///Color default untuk main thema
  static const MaterialColor mainTheme = MaterialColor(
    0xff0072FF,
    
    <int, Color>{
      50: Color(0xff0072FF),
      100: Color(0xff0072FF),
      200: Color(0xff0072FF),
      300: Color(0xff0072FF),
      400: Color(0xff0072FF),
      500: Color(0xff0072FF),
      600: Color(0xff0072FF),
      700: Color(0xff0072FF),
      800: Color(0xff0072FF),
      900: Color(0xff0072FF),
    },
  );

  ///Color default untuk dark thema
  static const MaterialColor darkTheme = MaterialColor(
    0xff141515,

    <int, Color>{
      50: Color(0xff141515),
      100: Color(0xff141515),
      200: Color(0xff141515),
      300: Color(0xff141515),
      400: Color(0xff141515),
      500: Color(0xff141515),
      600: Color(0xff141515),
      700: Color(0xff141515),
      800: Color(0xff141515),
      900: Color(0xff141515),
    },
  );
}

///warna ini dipisah karena agar tidak memakan tempat di main.dart dan mudah dalam mengelolanya