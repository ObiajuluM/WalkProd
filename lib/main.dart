import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkit/background/step_process_foreground_task.dart';
import 'package:walkit/firebase_options.dart';
import 'package:walkit/modules/auth/access_token_handling.dart';

import 'package:walkit/pages/primary/primary_page.dart';

import 'package:walkit/pages/splash/splash_page.dart';
import 'package:walkit/pages/splash/view/providers.dart';
import 'package:walkit/themes/dark.dart';
import 'package:walkit/themes/light.dart';
import 'package:walkit/themes/theme_provider.dart';

// TODO: i think using health connect will be somewhat inconsistent because the heallth connect pull step providers together and doesnt neccesarry aggregate the data from the different providers.
// TODO: ie: fit = 100 steps, samsung health = 200 steps, but helth connect might only show fit steps and not samsung steps

//TODO: health package needs proper looking into to avoid gaming the system.

Future<void> main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  // firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // force portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // streamed: might remove
  retrieveAccessTokenFromLocal();

  // set status bar color and nav bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Color.fromRGBO(103, 161, 197, 0.329),
    ),
  );

  /// step background --- start
  ///Initialize port for communication between TaskHandler and UI.
  // FlutterForegroundTask.initCommunicationPort();

  if (await FlutterForegroundTask.isRunningService == false) {
    ForegroundTaskService.init();
    //
    startService();
  }

  //
  /// step background --- stop

  // ///
  // ///
  // await initStepProcessNotification();
  // /// init work manager
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // /// start bkg task
  // Workmanager().registerPeriodicTask(
  //   "stepProcess",
  //   "stepProcess",
  //   backoffPolicy: BackoffPolicy.linear,
  //   initialDelay: Duration(seconds: 10),
  //   inputData: {
  //     "steps": step,
  //   },
  // );

  // load env files
  await dotenv.load();

  ///
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  /// function to check the current theme state and set it to stored state upon app launch
  toTheme() {
    SharedPreferences.getInstance().then((prefs) {
      bool isNight = prefs.getBool('night') ?? false;

      if (isNight == true) {
        ref.read(themeModeProvider.notifier).toDark();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    toTheme();

    final tokenStream = accessTokenStream.stream;

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ref.watch(themeModeProvider),

        ///
        home: StreamBuilder(
          stream: tokenStream,
          builder: (context, snapshot) {
            // log(snapshot.data.toString());
            // retrieveAccessTokenFromLocal();
            if (snapshot.hasData) {
              log("primarying in");
              return const PrimaryPage();
            } else {
              Future(() {
                ref.watch(splashPageIndexProvider.notifier).setIndex(0);
              });
              log("splashing in");
              return const SplashPage();
            }
          },
        ),
      ),
    );
  }
}
