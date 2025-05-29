import 'package:flutter/material.dart';
import 'package:todotestapp/data/const.dart';

final kLightTheme = ThemeData(
  colorSchemeSeed: kColorAccent,
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
  brightness: Brightness.light,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kColorTextFieldFillColor,
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    hintStyle: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: kColorButtonTextColor,
      backgroundColor: kColorButtonLightTheme,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusButtons),
      ),
      minimumSize: Size.fromHeight(50),
    ),
  ),
);
