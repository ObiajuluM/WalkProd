import 'dart:async';
import 'dart:developer';
import 'package:appcheck/appcheck.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';


healthConnectInstallPrompt(Health health) async {
  //  android only
  if (await health.isHealthConnectAvailable() == false) {
    await health.installHealthConnect();
  }
}

/// function to check if you have installed health connect
Future<bool> hasHealthConnect(Health health) async {
  bool enabled = false;

  // health
  await healthConnectInstallPrompt(health);
  //
  try {
    enabled =
        await AppCheck().isAppEnabled("com.google.android.apps.healthdata");
  } catch (e) {
    log(e.toString());
  }
  return enabled;
}

/// checks if all permissions are enabled then returns a future
Future<bool> permissionsEnabled() async {
  // Permission.sensors;

  // bool privacy = false;

  // Global Health instance
  final health = Health();
  // configure the health plugin before use.
  await health.configure();
  bool healthdata =
      await health.hasPermissions([HealthDataType.STEPS]) ?? false;

  // SharedPreferences.getInstance().then((prefs) => {
  //       privacy = prefs.getBool("privacy") ?? false,
  //     });

  final canProceed = await Permission.notification.isGranted &&
      await Permission.scheduleExactAlarm.isGranted &&
      await Permission.ignoreBatteryOptimizations.isGranted &&
      // check if health connect is installed
      await hasHealthConnect(health) &&
      healthdata;
  // &&
  // privacy;

  return canProceed;
}
