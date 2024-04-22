import 'dart:io';

import 'package:flutter/material.dart';

class InputDecorations {
  final String hintText;

  InputDecorations({required this.hintText});

  InputDecoration get loginDecoration {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(8),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFFA0A0A0),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFBEBEBE),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF0D6EFD),
          width: 0.5,
        ),
      ),
    );
  }

   InputDecoration get editDecoration {
    return InputDecoration(
      filled: true,
      fillColor: ColorStyles.bodyColor,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFFA0A0A0),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF0D6EFD),
          width: 0.5,
        ),
      ),
    );
  }
}

final lightTheme = ThemeData(
  useMaterial3: false,
  primaryColor: Colors.white,
  hintColor: Colors.white,
  canvasColor: ColorStyles.bodyColor,
  disabledColor: ColorStyles.primaryColor,
  primaryColorLight: Colors.black,
  
  scaffoldBackgroundColor: ColorStyles.bodyColor,
  brightness: Brightness.light,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorStyles.primaryColor,
  ),
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(color: Colors.white, width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
      color: Colors.white, 
      fontWeight: FontWeight.bold, 
      fontSize: 20
    ),
    elevation: Platform.isIOS ? 0 : 1,
    color: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  sliderTheme: const SliderThemeData(
    overlayColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
    titleMedium: TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.normal, 
      color: Colors.black
    ),
    titleSmall: TextStyle(
      color: Colors.black, 
      fontWeight: FontWeight.bold, 
      fontSize: 20
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(ColorStyles.primaryColor),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8))
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    )
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: ColorStyles.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    filled: true,
    fillColor: ColorStyles.bodyColor,
    labelStyle: const TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    collapsedTextColor: ColorStyles.primaryColor,
    textColor: ColorStyles.primaryColor,
    iconColor: Colors.grey
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(ColorStyles.primaryColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )
      ),
    ),
  ),
  indicatorColor: Colors.black,
);

class ColorStyles {
  static const Color accentColor = Color.fromRGBO(34, 34, 34, 1);
  static const Color bodyColorDark = Color.fromRGBO(20, 20, 20, 1);
  static const Color bodyColor = Color.fromRGBO(245, 248, 250, 1);
  static const Color primaryColor = Color.fromRGBO(43, 46, 74, 1);
  static Color lightShimmerBaseColor = Colors.grey[200]!;
  static Color lightShimmerHighlightColor = Colors.grey[100]!;
  static Color darkShimmerBaseColor = Colors.grey[800]!;
  static Color darkShimmerHighlightColor = Colors.grey[700]!;
}
