import 'package:flutter/material.dart';
import 'package:testapp/core/services/preference/preference.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark;
  ThemeProvider() {
    isDark =  true;
  }
  ThemeData dark = ThemeData(
    primaryColor: Color(0xffab351c),
    // textTheme: TextTheme().apply(bodyColor: Colors.white),
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xffab351c)),
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color(0xffab351c),
  );

  ThemeData light = ThemeData(
    primaryColor: Colors.blueAccent,
    // textTheme: TextTheme(body1: TextStyle(color: Colors.white).apply()),
    // textTheme: TextTheme().apply(bodyColor: Colors.orange, displayColor: Colors.orange),

    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.blueAccent,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "TeXGyreAdventor-Regular",
        fontSize: 11.181839942932129,
        color: Color(0xff939598),
      ),
      hintStyle: TextStyle(
        fontFamily: "NeusaNextW00-Regular",
        fontSize: 10.358949661254883,
        color: Color(0xff758091),
      ),
    ),
  );

  get switchTheme {
    isDark = !isDark;
    notifyListeners();
  }
}
