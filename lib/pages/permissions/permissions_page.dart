import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:walkit/pages/splash/view/providers.dart';

class PermissionsPage extends ConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsStateProvider);

    ///
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,

      ///
      // appBar: const CustomMiniAppBar(
      //   title: "Permissions",
      //   centerTitle: true,
      //   height: 100,
      // ),

      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Permissions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),

      ///
      body: ListView.builder(
        //  physics: NeverScrollableScrollPhysics(),
        itemCount: permissions.length,
        shrinkWrap: true,

        itemBuilder: (context, index) {
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
            child:
                // index == 4
                //     ? ListTile(
                //         key: ValueKey(index),
                //         onTap: () {
                //           // try {
                //           //   launchIt(privacy);
                //           // } catch (e) {
                //           //   log("splash permissions page error ${e.toString()}");
                //           // }
                //         },
                //         title: Text(
                //           permissions.keys.elementAt(index),
                //         ),
                //         subtitle: const Text(
                //           "Read and accept our privacy policy",
                //         ),
                //         trailing: Checkbox(
                //           value: permissions.values.elementAt(index),
                //           onChanged: (value) async {
                //             // update preference
                //             SharedPreferences.getInstance().then(
                //               (prefs) => {
                //                 prefs.setBool("privacy", true),
                //               },
                //             );

                //             // check status to again to update UI
                //             await ref
                //                 .read(permissionsStateProvider.notifier)
                //                 .permissionsStatus();
                //           },
                //         ),
                //       )
                // :
                SwitchListTile(
              contentPadding: const EdgeInsets.all(8),
              key: ValueKey(index),
              // isThreeLine: true,
              value: permissions.values.elementAt(index),

              ///
              onChanged: (value) async {
                // request the permission
                await ref
                    .read(permissionsStateProvider.notifier)
                    .requestPermission(index);

                // check status to again to update UI
                await ref
                    .read(permissionsStateProvider.notifier)
                    .permissionsStatus();
              },

              ///
              title: Text(
                permissions.keys.elementAt(index),
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
              subtitle: Text(
                index == 0
                    ? "Allow me to send notifications"
                    : index == 1
                        ? "Allow me to send routine notifications"
                        : index == 2
                            ? "Allow me to run in background"
                            : "Allow me to read your steps",
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
