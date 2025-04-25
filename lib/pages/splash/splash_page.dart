import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:walkit/global/constants.dart';
import 'package:walkit/modules/auth/authentication.dart';
import 'package:walkit/modules/auth/google_auth.dart';
import 'package:walkit/pages/splash/components/first_page.dart';
import 'package:walkit/pages/splash/components/fourth_page.dart';
import 'package:walkit/pages/splash/components/permissions_popup.dart';
import 'package:walkit/pages/splash/components/second_page.dart';
import 'package:walkit/pages/splash/components/third_page.dart';
import 'package:walkit/pages/splash/view/helper_methods.dart';
import 'package:walkit/pages/splash/view/providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  PageController splashPageController = PageController(initialPage: 0);

  @override
  void initState() {
    print("BUILT Splash PAGE");
    super.initState();
  }

  @override
  void dispose() {
    splashPageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///
    final currentPage = ref.watch(splashPageIndexProvider);

    ///
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Colors.transparent,

      ///
      body: Stack(
        children: [
          PageView.builder(
            controller: splashPageController,
            itemCount: 4,
            onPageChanged: (value) async {
              ref.read(splashPageIndexProvider.notifier).setIndex(value);
            },
            itemBuilder: ((context, index) => [
                  const SplashFirstPage(),
                  const SplashSecondPage(),
                  const SplashThirdPage(),
                  const SplashFourthPage(),
                ].elementAt(index)),
          ),

          ///
          /// Indicator Arrow - Visible until last page
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5, // Center vertically
            right: 20, // Position to the far right
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: currentPage < 3 ? 1.0 : 0.0, // Hide on last page
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),

      ///
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,

      ///
      // show the bottom floating slide action bar for page 2 for permissions
      floatingActionButton: currentPage == 2
          ? Container(
              margin: const EdgeInsets.all(10),
              child: ActionSlider.standard(
                backgroundColor: const Color(0xFF3A028E),
                toggleColor: const Color(0xFF7520CC),
                backgroundBorderRadius: BorderRadius.circular(16),
                foregroundBorderRadius: BorderRadius.circular(16),
                icon: Lottie.asset(
                  Icons8.key_password,
                  fit: BoxFit.fill,
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                ),
                action: (controller) {
                  // read status
                  ref
                      .read(permissionsStateProvider.notifier)
                      .permissionsStatus();

                  // begin loading animation
                  controller.loading();

                  /// show sheet
                  showModalBottomSheet(
                    clipBehavior: Clip.antiAlias,
                    enableDrag: true,
                    showDragHandle: true,
                    useSafeArea: true,
                    
                    // backgroundColor: Colors.white,

                    context: context,
                    builder: (context) => const SplashPermissionsPopUp(),
                  ).then(
                    (value) async {
                      // after the user is done with the pop up - check if all permissions are gtg and then push to the next page
                      controller.reset();

                      if (await permissionsEnabled() == true) {
                        ref.watch(splashPageIndexProvider.notifier).setIndex(3);
                        splashPageController.jumpToPage(3);
                      }
                    },
                  );

                  ///
                },
                child: const Text(
                  "Request Permissions",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )

          //  show the bottom floating slide action bar for page 3, to sign in
          : currentPage == 3
              ? FutureBuilder(
                  future: permissionsEnabled(),
                  builder: (context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: snapshot.hasData && snapshot.data == true
                          ? ActionSlider.standard(
                              backgroundBorderRadius: BorderRadius.circular(16),
                              foregroundBorderRadius: BorderRadius.circular(16),
                              toggleColor: const Color(0xFF2183CD),
                              backgroundColor: const Color(0xFF025E8E),
                              icon: Lottie.asset(
                                Icons8.walk,
                                fit: BoxFit.fill,
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                              ),
                              loadingIcon: Lottie.asset(
                                Icons8.load_from_cloud,
                                fit: BoxFit.fill,
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                              ),
                              action: (controller) async {
                                controller.loading();

                                final accesstoken = await signInWithGoogle();

                                if (accesstoken == null) {
                                } else {
                                  await WalkItBackendAuth()
                                      .signInWithCredential(
                                    djangoClientId: kDjangoClientID,
                                    googleAccessToken: accesstoken,
                                  );
                                }

                                controller.reset();
                              },
                              child: const Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const Text(
                              "Please allow all permissions and enable health connect!",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    );
                  },
                )
              : null,
    );
  }
}
