import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'MontserratAlternates',
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromRGBO(103, 161, 197, 1),
  ),

  //
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontFamily: 'MontserratAlternates',
      color: Color.fromRGBO(221, 221, 221, 1),
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 0,
    ),
    subtitleTextStyle: TextStyle(
      fontFamily: 'MontserratAlternates',
      color: Color.fromRGBO(122, 118, 118, 1),
      fontSize: 11,
      fontWeight: FontWeight.w300,
      height: 0,
    ),
  ),

  //
  // snackBarTheme: const SnackBarThemeData(
  //   backgroundColor: Color(0xFF21272B),
  // ),

  //
  scaffoldBackgroundColor: const Color.fromRGBO(24, 29, 31, 1),
  bottomSheetTheme: const BottomSheetThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color.fromRGBO(24, 29, 31, 1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF394861),
    surfaceTintColor: Colors.transparent,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF21272B),
    showUnselectedLabels: false,
    showSelectedLabels: false,
    selectedIconTheme: IconThemeData(
      size: 39,
      color: Color(0xFF394861),
    ),
    unselectedIconTheme: IconThemeData(
      size: 39,
      color: Color.fromRGBO(221, 221, 221, 1),
    ),
  ),
);
