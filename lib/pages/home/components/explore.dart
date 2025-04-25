import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:walkit/global/helper_methods.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/pages/home/view/providers.dart';

class Explore extends ConsumerWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthData = ref.watch(healthDataProvider);
    final user = ref.watch(backendUserProvider);

    ///
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 9),

      ///
      title: const Text(
        "Explore",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color.fromRGBO(131, 131, 131, 1),
          fontSize: 14,
          fontWeight: FontWeight.w700,
          // height: 0,
        ),
      ),

      ///
      subtitle: GridView.builder(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // number of items in each row
          mainAxisSpacing: 0.0, // spacing between rows
          crossAxisSpacing: 0.0, // spacing between columns
        ),
        itemBuilder: (context, index) => Card(
          clipBehavior: Clip.antiAlias,
          color: (index == 0 &&
                  Theme.of(context).brightness == Brightness.light)
              ? const Color(0xFFC37030)
              : (index == 0 && Theme.of(context).brightness == Brightness.dark)
                  ? const Color(0xFF83350D)
                  : (index == 1 &&
                          Theme.of(context).brightness == Brightness.light)
                      ? const Color(0xFFC02E5A)
                      : (index == 1 &&
                              Theme.of(context).brightness == Brightness.dark)
                          ? const Color(0xFF830C3B)
                          : (index == 2 &&
                                  Theme.of(context).brightness ==
                                      Brightness.light)
                              ? const Color(0xFF7520CC)
                              : (index == 2 &&
                                      Theme.of(context).brightness ==
                                          Brightness.dark)
                                  ? const Color(0xFF3A028E)
                                  : (index == 3 &&
                                          Theme.of(context).brightness ==
                                              Brightness.light)
                                      ? const Color(0xFF2183CD)
                                      : const Color(0xFF025E8E),
          child: InkWell(
            onTap: index == 0
                ? () async {
                    try {
                      shareText(
                        message:
                            "I have walked ${healthData['steps']} steps today with @WalkItApp, How many have you? #WalkWithWalkIt",
                        subject: "Walk It Challenge",
                      );
                    } catch (e) {
                      log(
                        "an error occurred",
                        error: e,
                        name: "share plus package error",
                      );
                    }
                  }
                : index == 3
                    ? () async {
                        try {
                          await shareText(
                            message:
                                'Hi, I am inviting you to Walk It. A web3 app that rewards you to walk - Use my code ${user.invite_code} after you sign up to receive a bonus',
                            subject: "Invitation",
                          );
                        } catch (e) {
                          log(
                            "an error occurred",
                            error: e,
                            name: "share plus package error",
                          );
                        }
                      }
                    : () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : const Color(0xFF21272B),
                            content: Text(
                              "Coming Soon!",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black87
                                    : Colors.white70,
                              ),
                            ),
                          ),
                        );
                      },
            onTapDown: null,
            child: Icon(
              index == 0
                  ? LineIcons.running
                  : index == 1
                      ? Icons.wifi_calling_3_outlined
                      : index == 2
                          ? LineIcons.gifts
                          : Icons.group_add_outlined,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
            ),
          ),
          //  share steps / challeenge - gift
          // airtime
          // earnmore // lucky (spin), ads
          // invite a friend
        ),
      ),
    );
  }
}
