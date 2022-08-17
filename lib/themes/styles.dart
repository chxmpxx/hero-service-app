import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Montserrat',
    // สีหลัก
    primaryColor: Colors.purple,
    // สีพวก status bar ต่าง ๆ
    accentColor: Colors.purpleAccent,
    buttonColor: Colors.pink
  );
}