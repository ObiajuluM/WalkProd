import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:intl/intl.dart';
import 'package:walkit/global/helper_methods.dart';
import 'package:walkit/modules/backend/requests.dart';

const channelId = "Walk It Foreground Channel Id";
const channelName = "Walk It Foreground Service Notification";
const channelDescription =
    "This notification appears when the walk it foreground service is running.";

///
class ForegroundTaskService {
  static init() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: channelId,
        channelName: channelName,
        channelDescription: channelDescription,
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(
          const Duration(
            minutes: 15,
          ).inMilliseconds,
        ),
        // eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        // allowWifiLock: true,
      ),
    );
  }
}

// This decorator means that this function calls native code
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

// void startService() async {
void startService() async {
  final healthSteps = await getBackgroundStepCount();
  if (await FlutterForegroundTask.isRunningService) {
    FlutterForegroundTask.restartService();
  } else {
    // show step notification
    FlutterForegroundTask.startService(
      notificationTitle: "$healthSteps steps today",
      notificationText: "",
      callback: startCallback, // Function imported from ForegroundService.dart
    );
  }
}

class MyTaskHandler extends TaskHandler {
  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    ///
    print('onStart(starter: ${starter.name})');

    // get steps
    final healthSteps = await getBackgroundStepCount();

    await rewardAndLogSteps(healthSteps);

    // set initial step notification
    FlutterForegroundTask.startService(
      notificationTitle: "$healthSteps steps today",
      notificationText: "",
      callback: startCallback, // Function imported from ForegroundService.dart
    );
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) async {
    log("object  repeated ${timestamp}");
    final healthSteps = await getBackgroundStepCount();

    await rewardAndLogSteps(healthSteps);

    // update step notification
    FlutterForegroundTask.updateService(
      // notificationTitle: "${await getBackgroundStepCount()} steps today",
      notificationTitle: "$healthSteps steps today",
      notificationText: "",
    );
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('onDestroy');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) {
    print('onReceiveData: $data');
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed: $id');
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    print('onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    print('onNotificationDismissed');
  }
}

/// method to log steps to backend and show love
Future<void> rewardAndLogSteps(int healthSteps) async {
  // load env files
  await dotenv.load();

  // if time is 23:00 and steps are greater than 100
  if (DateTime.now().hour == 23 && healthSteps >= 100) {
    print("enter 1");

    ///  if the getUserLastRecordedSteps fails, it is most likely because
    /// there was no object to modify in the first place, so skip the error and show love
    try {
      final lastRecordedSteps = await getUserLastRecordedSteps();
    } catch (e) {
      log("showed love due to error: $e");
      uploadSteps(healthSteps);
    }

    /// try to show love if the last recorded steps time is not today
    try {
      print("tried 2");
      final lastRecorded = await getUserLastRecordedSteps();
      final lastTime = DateFormat('yyyy-MM-dd').parse(lastRecorded["time"]);
      print(lastTime.toString());

      if (
          // DateTime.now().month != lastTime.month &&
          DateTime.now().day != lastTime.day) {
        print("last time is not today");
        log("enter 2");
        uploadSteps(healthSteps);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
