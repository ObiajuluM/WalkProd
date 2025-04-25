import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'MontserratAlternates',
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(103, 161, 197, 1),
    brightness: Brightness.light,
  ),

  //
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontFamily: 'MontserratAlternates',
      color: Color(0xFF5E5E5E),
      // const Color.fromRGBO(91, 91, 91, 1),
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 0,
    ),
    subtitleTextStyle: TextStyle(
      fontFamily: 'MontserratAlternates',
      color: Color(0xFF5E5E5E),
      fontSize: 11,
      fontWeight: FontWeight.w300,
      height: 0,
    ),
  ),

  //
  // snackBarTheme: const SnackBarThemeData(
  //   backgroundColor: Colors.white,
  // ),

  //
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(103, 161, 197, 1),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(226, 237, 244, 1),
  bottomSheetTheme: const BottomSheetThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color.fromRGBO(226, 237, 244, 1),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    showUnselectedLabels: false,
    showSelectedLabels: false,
    // type: BottomNavigationBarType.fixed,
    selectedIconTheme: IconThemeData(
      size: 39,
      color: Color.fromRGBO(103, 161, 197, 1),
    ),
    unselectedIconTheme: IconThemeData(
      size: 39,
      color: Color.fromRGBO(221, 221, 221, 1),
    ),
  ),
);
