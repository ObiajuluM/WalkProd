import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/background/step_process_foreground_task.dart';
import 'package:walkit/global/helper_methods.dart';
import 'package:walkit/global/view/provider.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/pages/discover/discover_page.dart';
import 'package:walkit/pages/home/home_page.dart';
import 'package:walkit/pages/home/view/providers.dart';
import 'package:walkit/pages/primary/view/providers.dart';
import 'package:walkit/pages/profile/profile_page.dart';
import 'package:walkit/pages/settings/settings_page.dart';
import 'package:walkit/walk_it_icons.dart';

class PrimaryPage extends ConsumerStatefulWidget {
  const PrimaryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends ConsumerState<PrimaryPage> {
  PageController primaryPageController = PageController(initialPage: 0);

  @override
  void initState() {
    log("BUILT PRIMARY PAGE");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    primaryPageController.dispose();
  }

// load data that is needed per page basis
  loadData(int index) async {
    try {
      if (index == 0) {
        //greet
        ref.read(greetingProvider.notifier).greet();
        // get health
        ref.read(healthDataProvider.notifier).getData();

        //  get backend user
        await ref.read(backendUserProvider.notifier).getData();

        log("called page 0");
      }
      //
      //
      else if (index == 1) {
        //  get backend user
        await ref.read(backendUserProvider.notifier).getData();
        //   log("called page 1");
        // } else if (index == 2) {
        // } else if (index == 3) {
        //   ref.read(globalDBProvider.notifier).getData();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ///
    final currentPage = ref.watch(primaryPageIndexProvider);

    // call data per page
    Future(() async {
      await loadData(currentPage);
    });

    ///
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,

      ///
      body: PageView.builder(
        controller: primaryPageController,
        itemCount: 4,
        onPageChanged: (value) async {
          ref.read(primaryPageIndexProvider.notifier).setIndex(value);

          // await rewardAndLogSteps(await getBackgroundStepCount());
        },
        itemBuilder: ((context, index) => const [
              HomePage(),
              ProfilePage(),
              DiscoverPage(),
              SettingsPage(),
            ].elementAt(index)),
      ),

      ///
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 8.0,
        ),
        child: Container(
          height: 86,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadows: [
              Theme.of(context).brightness == Brightness.light
                  ? const BoxShadow(
                      color: Color.fromRGBO(103, 161, 197, 0.329),
                      blurRadius: 16.10,
                      offset: Offset(0, 4),
                      spreadRadius: 12,
                    )
                  : const BoxShadow(
                      color: Color(0x9E000000),
                      blurRadius: 26.60,
                      offset: Offset(0, 4),
                      spreadRadius: 11,
                    ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (index) {
              // jump to page
              ref.read(primaryPageIndexProvider.notifier).setIndex(index);
              primaryPageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(WalkItIcons.home),
                label: "_",
                tooltip: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(WalkItIcons.profile),
                label: "_",
                tooltip: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(WalkItIcons.discover),
                label: "_",
                tooltip: "Discover",
              ),
              BottomNavigationBarItem(
                icon: Icon(WalkItIcons.settings),
                label: "_",
                tooltip: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
