// import 'dart:math';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:walkit/pages/splash/view/helper_methods.dart';
import 'package:health/health.dart';
import 'package:walkit/pages/splash/view/helper_methods.dart';

class SplashPageIndexProvider extends StateNotifier<int> {
  SplashPageIndexProvider() : super(0);

  setIndex(int index) {
    state = index;
  }
}

final splashPageIndexProvider =
    StateNotifierProvider<SplashPageIndexProvider, int>((ref) {
  return SplashPageIndexProvider();
});

///

/// gives us the current state of the permissions in our splash page
class PermissionsStateProvider extends StateNotifier<Map<String, bool>> {
  PermissionsStateProvider()
      : super({
          "Send Notification": false,
          "Schedule Alarms": false,
          "Ignore Battery Optimizations": false,
          "Read Step Data": false,
          // "Privacy Policy": false,
        });

  requestPermission(int index) async {
    ///

    index == 0
        ? await Permission.notification.request()
        : index == 1
            ? await Permission.scheduleExactAlarm.request()
            : index == 2
                ? await Permission.ignoreBatteryOptimizations.request()
                : await Health().requestAuthorization([HealthDataType.STEPS]);
  }

  Future<Map<String, bool>> permissionsStatus() async {
    // bool privacy = false;

    // Global Health instance
    final health = Health();

    // configure the health plugin before use.
    await health.configure();
    bool healthdata = false;

    // check health
    try {
      healthdata = await health.hasPermissions([HealthDataType.STEPS]) ?? false;
    } catch (e) {
      log(e.toString());
      hasHealthConnect(health);
    }

    // check if privacy and terms where agreed on
    // SharedPreferences.getInstance().then((prefs) => {
    //       privacy = prefs.getBool("privacy") ?? false,
    //     });

    state = {
      // "Location": await Geolocator.isLocationServiceEnabled() &&
      //     await Permission.location.isGranted,
      // "Activity Recognition": await Permission.activityRecognition.isGranted,
      "Send Notification": await Permission.notification.isGranted,
      "Schedule Alarms": await Permission.scheduleExactAlarm.isGranted,
      "Ignore Battery Optimizations":
          await Permission.ignoreBatteryOptimizations.isGranted,
      "Read Step Data": healthdata,
      // "Privacy Policy": privacy,
    };

    return {
      // "Activity Recognition": await Permission.activityRecognition.isGranted,
      "Send Notification": await Permission.notification.isGranted,
      "Schedule Alarms": await Permission.scheduleExactAlarm.isGranted,
      "Ignore Battery Optimizations":
          await Permission.ignoreBatteryOptimizations.isGranted,
      "Read Step Data": healthdata,
      // "Privacy Policy": privacy,
    };
  }
}

final permissionsStateProvider =
    StateNotifierProvider<PermissionsStateProvider, Map<String, bool>>((ref) {
  return PermissionsStateProvider();
});
