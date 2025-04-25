import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/pages/splash/view/providers.dart';

class SplashPermissionsPopUp extends ConsumerStatefulWidget {
  const SplashPermissionsPopUp({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SplashPermissionsPopUpState();
}

class _SplashPermissionsPopUpState
    extends ConsumerState<SplashPermissionsPopUp> {
  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(permissionsStateProvider);
    // const privacy = "https://walkitapp.com/privacy-policy.html";

    //
    return StatefulBuilder(
      builder: (context, state) {
        // final permissions = ref.watch(permissionsStateProvider);
        return ListView.builder(
          //  shrinkWrap: true,
          itemCount: permissions.length,
          itemBuilder: (context, index) => SwitchListTile(
            key: ValueKey(index),
            isThreeLine: true,
            value: permissions.values.elementAt(index),
            // value: false,

            ///
            title: Text(
              permissions.keys.elementAt(index),
              style: const TextStyle(
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
                          ? "Allow me to run in background, without interruptions"
                          : "Allow me to read your steps.\nMake sure you have Google Fit installed and connected to Health Connect.",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),

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
          ),
        );
      },
    );
  }
}
