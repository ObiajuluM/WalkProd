// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:health/health.dart';
// import 'package:walkit/global/helper_methods.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// Future<bool> isBackgroundTaskRunning() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('backgroundTaskRunning') ?? false;
// }

// Future<void> setBackgroundTaskRunning(bool isRunning) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('backgroundTaskRunning', isRunning);
// }

// // notification channel id
// const androidNotificationChannelId = "Walk It";

// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 12345;

// // channel description
// const channelDescription = "Walk It background process channel";

// Future<FlutterLocalNotificationsPlugin> initStepProcessNotification() async {
//   // init local notification
//   final flnp = FlutterLocalNotificationsPlugin();
//   try {
//     // create notification channel instance
//     const notificationChannel = AndroidNotificationChannel(
//       androidNotificationChannelId,
//       androidNotificationChannelId,
//       description: channelDescription,
//       importance: Importance.low,
//       showBadge: false,
//     );

//     await flnp
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .initialize(
//           const AndroidInitializationSettings("@mipmap/ic_launcher"),
//         );

//     //req permission
//     await flnp
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();
//     //req permission
//     await flnp
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestExactAlarmsPermission();

//     // create notification channel for platform
//     await flnp
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .createNotificationChannel(notificationChannel);
//   } catch (e) {
//     print(e);
//   }
//   return flnp;
// }

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask(
//     (task, inputData) async {
//       // if the running task is task 1, do this
//       if (task == "stepProcess") {
//         log("stepProcess ${DateTime.now()}");

//         int stepCount = 0;
//         try {
//           final health = Health();
//           // configure the health plugin before use.
//           await health.configure();

//           const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];
//           // get steps for today (i.e., since midnight)
//           // today
//           final now = DateTime.now();
//           // midnight
//           final midnight = DateTime(now.year, now.month, now.day);

//           /// get steps and set state
//           List<HealthDataPoint> healthSteps =
//               await health.getHealthDataFromTypes(
//             startTime: midnight,
//             endTime: now,
//             types: kdataTypes,
//             recordingMethodsToFilter: [
//               // TODO: come back to this later there is an issue here: https://pub.dev/packages/health
//               // RecordingMethod.unknown,
//               // RecordingMethod.manual,
//               // RecordingMethod.automatic,
//               // RecordingMethod.active,
//             ],
//           );

//           for (var steps in healthSteps) {
//             stepCount += steps.value.toJson()["numericValue"] as int;
//           }
//         } catch (e) {
//           print("ERROR IN BACKGORUND STEP RETRIEVAL $e");
//         }

//         ///
//         // int steps = stepCount;

//         // if (inputData != null) {
//         //   steps = inputData['steps'];
//         // }

//         final flnp = FlutterLocalNotificationsPlugin();

//         // show notification
//         flnp.show(
//           notificationId,
//           null,
//           "$stepCount steps today",
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               androidNotificationChannelId,
//               androidNotificationChannelId,
//               channelDescription: channelDescription,

//               importance: Importance.low,
//               priority: Priority.low,
//               showWhen: false,

//               ///
//               autoCancel: false,
//               channelShowBadge: false,
//               ongoing: true,
//               color: Colors.transparent,
//               silent: true,
//               category: AndroidNotificationCategory.progress,
//               when: null,
//               visibility: NotificationVisibility
//                   .public, // show notification on lock screen
//               // channelAction: AndroidNotificationChannelAction.update, // this updates an existing channel
//             ),
//           ),
//         );
//       }

//       return Future.value(true);
//     },
//   );
// }
