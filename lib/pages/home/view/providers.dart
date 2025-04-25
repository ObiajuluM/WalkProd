import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/global/helper_methods.dart';

class HealthDataProvider extends StateNotifier<Map<String, int>> {
  HealthDataProvider() : super({"steps": 0000});

  Future<void> getData() async {
    state = {"steps": await getStepsFromProvider()};

    // bool hasPermission = false;
    // List<HealthDataPoint> healthSteps;
    // int step_count = 0;
    // try {
    //   // Global Health instance
    //   final health = Health();
    //   // configure the health plugin before use.
    //   await health.configure();

    //   const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];

    //   // get steps for today (i.e., since midnight)
    //   // today
    //   final now = DateTime.now();
    //   // midnight
    //   final midnight = DateTime(now.year, now.month, now.day);

    //   hasPermission = await health.hasPermissions(kdataTypes) ?? false;

    //   if (hasPermission) {
    //     /// get steps and set state
    //     healthSteps = await health.getHealthDataFromTypes(
    //         startTime: midnight,
    //         endTime: now,
    //         types: kdataTypes,
    //         recordingMethodsToFilter: [
    //           // TODO: come back to this later there is an issue here: https://pub.dev/packages/health
    //           // RecordingMethod.unknown,
    //           // RecordingMethod.manual,
    //           // RecordingMethod.automatic,
    //           // RecordingMethod.active,
    //         ]);

    //     for (var steps in healthSteps) {
    //       // print(steps.toJson());
    //       step_count += steps.value.toJson()["numericValue"] as int;
    //     }
    //     print(step_count);

    //     // print(healthSteps.first.value.toJson()["numericValue"]);
    //     // print(healthSteps.first.value.toJson())

    //     // log(healthSteps.toString());

    //     ///
    //     state = {"steps": step_count};
    //     // state = {
    //     //   "steps": await health.getTotalStepsInInterval(
    //     //         midnight,
    //     //         now,
    //     //         includeManualEntry: true,
    //     //       ) ??
    //     //       0000
    //     // };
    //   } else {
    //     hasPermission =
    //         await health.requestAuthorization(kdataTypes).then((value) {
    //       getData();
    //       return true;
    //     });
    //   }
    // } catch (e) {
    //   print(e);
    // }

    // print("object");
  }
}

final healthDataProvider =
    StateNotifierProvider<HealthDataProvider, Map<String, int>>((ref) {
  return HealthDataProvider();
});
