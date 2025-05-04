import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:random_avatar/random_avatar.dart';
import 'dart:math' as math;
import 'package:walkit/modules/backend/requests.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    return Scaffold(
      extendBody: true,

      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Daily Leaderboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      surfaceTintColor: Colors.transparent,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : const Color(0xFF242B2E),
                      actionsAlignment: MainAxisAlignment.center,
                      content: Text(
                        // yesterday
                        "Leaderboard for ${DateFormat.yMMMMEEEEd().format(DateTime.now().subtract(const Duration(days: 1)))}",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    )),
              );
            },
            icon: LineIcon.calendar(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromRGBO(34, 40, 43, 1),
            ),
          )
        ],
      ),

      ///
      body: FutureBuilder(
        future: getLeaderBoard(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      margin: const EdgeInsets.all(4),
                      shadowColor: const Color.fromRGBO(103, 161, 197, 0.329),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        tileColor: index == 0
                            ? const Color.fromRGBO(104, 222, 172, 1)
                            : index == 1
                                ? Colors.deepOrange
                                : index == 2
                                    ? const Color.fromRGBO(220, 174, 151, 1)
                                    : Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(0.4),
                        leading: RandomAvatar(
                          snapshot.data!.elementAt(index).display_name!,
                          height: 34,
                          width: 34,
                        ),
                        title: Text(
                          snapshot.data!.elementAt(index).display_name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // color: Color.fromRGBO(82, 82, 82, 1),

                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromRGBO(82, 82, 82, 1)
                                    : Color.fromARGB(255, 221, 220, 220),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        trailing: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            index == 0
                                ? const Icon(
                                    Icons.star_rounded,
                                    color: Colors.yellow,
                                  )
                                : const SizedBox(),
                            index == 1
                                ? const Icon(
                                    Icons.star_rounded,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                            index == 2
                                ? const Icon(
                                    Icons.star_rounded,
                                    color: Colors.brown,
                                  )
                                : const SizedBox(),

                            ///
                            Wrap(
                              direction: Axis.vertical,
                              // mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Text(
                                  snapshot.data!
                                      .elementAt(index)
                                      .steps!
                                      .toString(),
                                  // textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  semanticsLabel: "step count",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                const Text(
                                  "steps",
                                  semanticsLabel: "step",
                                  // textAlign: TextAlign.right,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'All truly great thoughts are conceived while walking.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF5E5E5E)
                          : const Color.fromRGBO(221, 221, 221, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
