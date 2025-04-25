import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:walkit/themes/dark.dart';
// import 'package:walkit/themes/light.dart';

// class ThemeProvider extends StateNotifier<ThemeData> {
//   ThemeProvider() : super(lightTheme);

//   Future<void> toggleTheme() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     // set state in UI
//     if (state == darkTheme) {
//       state = lightTheme;
//       // set night theme as false in shared preferences
//       await prefs.setBool('night', false);
//     } else {
//       state = darkTheme;
//       // set night theme as true in shared preferences
//       await prefs.setBool('night', true);
//     }

//     // state = state == darkTheme ? lightTheme : darkTheme;
//     // set state in local storage
//     // state == darkTheme
//     //     ? await prefs.setBool('night', true)
//     //     : await prefs.setBool('night', false);
//   }
// }

// final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>((ref) {
//   return ThemeProvider();
// });

class ThemeModeProvider extends StateNotifier<ThemeMode> {
  ThemeModeProvider() : super(ThemeMode.system);

  Future<void> changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);

    // print(" is dark 1: ${prefs.getBool('night')}");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // // set state in UI
    // if (state == ThemeMode.dark) {
    //   state = ThemeMode.light;
    //   // set night theme as false in shared preferences
    //   await prefs.setBool('night', false);
    // } else {
    //   state = ThemeMode.dark;
    //   // set night theme as true in shared preferences
    //   await prefs.setBool('night', true);
    // }

    // state = state == darkTheme ? lightTheme : darkTheme;
    // set state in local storage
    // state == darkTheme
    //     ? await prefs.setBool('night', true)
    //     : await prefs.setBool('night', false);
  }

  toDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);

    // print(" is dark 2: ${prefs.getBool('night')}");
  }

  toLight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = ThemeMode.light;

    // set state in local storage
    state == ThemeMode.light
        ? await prefs.setBool('night', false)
        : await prefs.setBool('night', true);

    // print(" is dark 2: ${prefs.getBool('night')}");
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeProvider, ThemeMode>((ref) {
  return ThemeModeProvider();
});
