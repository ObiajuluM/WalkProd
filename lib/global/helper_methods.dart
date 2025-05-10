import 'package:health/health.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// formats invite to multi zero text
String inviteCountify(int userInvitesLength) {
  int referrals = userInvitesLength;
  // getUserInvites().then((onValue) {
  //   referrals = onValue.length;
  // });

  final nreferrals = "0$referrals";
  return referrals > 9 && referrals <= 99
      ? nreferrals
      : referrals <= 10
          ? "00$referrals"
          : "$referrals";
}

Future<void> launchIt(String _url) async {
  final Uri url = Uri.parse(_url);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

/// function to share text, triggers - sharing native ui
Future<void> shareText(
    {required String message, required String subject}) async {
  try {
    Share.share(
      message,
      subject: subject,
    );
  } catch (e) {
    throw Exception("an error occurred $e share plus package error ");
  }
}

/// get step count for background shit
Future<int> getBackgroundStepCount() async {
  int stepCount = 0;
  try {
    final health = Health();
    // configure the health plugin before use.
    await health.configure();

    const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];
    // get steps for today (i.e., since midnight)
    // today
    final now = DateTime.now();
    // midnight
    final midnight = DateTime(now.year, now.month, now.day);

    /// get steps and set state
    List<HealthDataPoint> healthSteps = await health.getHealthDataFromTypes(
      startTime: midnight,
      endTime: now,
      types: kdataTypes,
      recordingMethodsToFilter: [
        // TODO: come back to this later there is an issue here: https://pub.dev/packages/health, the below types of recording methods are not working

        //TODO: filter out steps from different providers  "source_platform": "appleHealth",
        // RecordingMethod.unknown,
        // RecordingMethod.manual,
        // RecordingMethod.automatic,
        // RecordingMethod.active,
      ],
    );

// TODO: look into this 2 methods and any more if available
    // health.getHealthAggregateDataFromTypes(types: types, startDate: startDate, endDate: endDate);
    // health.getTotalStepsInInterval(startTime, endTime)

    for (var steps in healthSteps) {
      stepCount += steps.value.toJson()["numericValue"] as int;
    }
  } catch (e) {
    print("ERROR IN BACKGORUND STEP RETRIEVAL $e");
  }
  return stepCount;
}

// get steps from the health plugin provider
Future<int> getStepsFromProvider() async {
  bool hasPermission = false;
  int stepCount = 0;
  try {
    // Global Health instance
    final health = Health();
    // configure the health plugin before use.
    await health.configure();

    const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];

    // get steps for today (i.e., since midnight)
    // today
    final now = DateTime.now();
    // midnight
    final midnight = DateTime(now.year, now.month, now.day);

    hasPermission = await health.hasPermissions(kdataTypes) ?? false;

    if (hasPermission) {
      /// get steps and set state
      List<HealthDataPoint> healthSteps = await health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: kdataTypes,
        recordingMethodsToFilter: [
          // TODO: come back to this later there is an issue here: https://pub.dev/packages/health
          // RecordingMethod.unknown,
          // RecordingMethod.manual,
          // RecordingMethod.automatic,
          // RecordingMethod.active,
        ],
      );

      for (var steps in healthSteps) {
        stepCount += steps.value.toJson()["numericValue"] as int;
      }
    } else {
      hasPermission =
          await health.requestAuthorization(kdataTypes).then((value) {
        getStepsFromProvider();
        return true;
      });
    }
  } catch (e) {
    print(e);
  }

  print(stepCount);
  return stepCount;
}
