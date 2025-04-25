import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:walkit/global/components/mini_app_bar.dart';
import 'package:walkit/global/helper_methods.dart';
import 'package:walkit/pages/permissions/permissions_page.dart';
import 'package:walkit/pages/settings/components/sign_out_dialog.dart';
import 'package:walkit/pages/settings/components/socials_popup.dart';
import 'package:walkit/pages/splash/view/providers.dart';

import 'package:walkit/themes/theme_provider.dart';
import 'package:walkit/walk_it_icons.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const privacy = "https://walkitapp.com/privacy-policy.html";

    const twitter = "https://x.com/walkitapp";
    const telegram = "https://t.me/walkitapp";
    const bugReportFeedback = "https://forms.gle/H457CCbHJ7TXobLu6";

    ///
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,

      ///
      appBar: const CustomMiniAppBar(
        title: "Settings",
        centerTitle: true,
        height: 100,
      ),

      ///
      body: ListView.builder(
        //  physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,

        // i renamed context to listcontext to avoid conflicts with the context of the build method.
        itemBuilder: (listcontext, index) {
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
            shadowColor: Theme.of(context).brightness == Brightness.light
                ? const Color.fromRGBO(103, 161, 197, 0.329)
                : const Color(0xFF000000),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF20262A),

            ///
            child: ListTile(
                contentPadding: const EdgeInsets.all(8),

                /// go to permissions
                onTap: () {
                  index == 0
                      //  navigate to permissions page
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // Check permissions before page loading
                              ref
                                  .read(permissionsStateProvider.notifier)
                                  .permissionsStatus();
                              return const PermissionsPage();
                            },
                          ),
                        )
                      // change theme
                      : index == 1
                          ? ref.read(themeModeProvider.notifier).changeTheme()
                          // open privacy page
                          : index == 2
                              ? launchIt(privacy)
                              : index == 3
                                  // open sign out dialog
                                  ? showDialog(
                                      context: context,
                                      builder: ((context) =>
                                          const SignOutDialog()),
                                    )
                                  // open bug report and feedback
                                  : index == 4
                                      ? launchIt(bugReportFeedback)
                                      // show socials

                                      : showModalBottomSheet(
                                          showDragHandle: true,
                                          enableDrag: true,
                                          context: context,
                                          builder: ((context) => const SizedBox(
                                                height: 200,
                                                child: SocialsPopup(
                                                  telegram: telegram,
                                                  website: privacy,
                                                  twitter: twitter,
                                                ),
                                              )),
                                        );
                },

                ///
                leading: Icon(
                  index == 0
                      ? Icons.key_rounded
                      : (index == 1 &&
                              Theme.of(context).brightness == Brightness.light)
                          ? WalkItIcons.sun
                          : (index == 1 &&
                                  Theme.of(context).brightness ==
                                      Brightness.dark)
                              ? LineIcons.moon
                              : index == 2
                                  ? Icons.privacy_tip_outlined
                                  : index == 3
                                      ? WalkItIcons.signout
                                      : index == 4
                                          ? Icons.bug_report_outlined
                                          : LineIcons.globe,
                  color: index == 1 &&
                          Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFFFFB700)
                      : index == 1 &&
                              Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF8E8D8D)
                          : index == 3 || index == 4
                              ? const Color(0xFFF16D75)
                              : index == 0 ||
                                      index == 1 ||
                                      index == 2 ||
                                      index == 3 ||
                                      index == 5
                                  ? const Color(0xFF11689E)
                                  : Colors.amber,
                ),

                ///
                title: Text(
                  index == 0
                      ? 'Permissions'
                      : index == 1
                          ? 'App look'
                          : index == 2
                              ? 'Privacy Policy'
                              : index == 3
                                  ? 'Sign out'
                                  : index == 4
                                      ? 'Bug report and Feedback'
                                      : "Socials",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFF5E5E5E)
                        : const Color.fromRGBO(221, 221, 221, 1),
                    // const Color.fromRGBO(91, 91, 91, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),

                ///
                trailing: index == 1
                    ? Text(
                        Theme.of(context).brightness == Brightness.light
                            ? "Light mode"
                            : Theme.of(context).brightness == Brightness.dark
                                ? "Night mode"
                                : "System",
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF5E5E5E)
                                  : const Color(0xFF7A7676),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )
                    : null),
          );
        },
      ),
    );
  }
}
