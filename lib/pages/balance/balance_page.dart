import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:walkit/global/components/medium_app_bar.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/modules/backend/requests.dart';

class BalancePage extends ConsumerStatefulWidget {
  const BalancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BalancePageState();
}

class _BalancePageState extends ConsumerState<BalancePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(backendUserProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,

      ///
      appBar: CustomMediumAppBar(
        ///
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFF68DEAC)
            : const Color(0xff23a06b),

        ///
        title: "Balance",

        ///
        content: ListTile(
          title: Center(
            child: Text(
              "${user.balance?.toStringAsFixed(1)}",
              maxLines: 1,
              semanticsLabel: "${user.balance?.toStringAsFixed(1)}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "EvilEmpire",
                color: Colors.white,
                fontSize: 96,
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -3.84,
              ),
            ),
          ),
        ),

        ///
        footer: Card(
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFF85B4D1)
              : const Color(0xFF394861),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            // onTap: () {},
            title: Center(
              child: Text(
                "Walk points",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ),

      // body:  use list view.seperated by the date,

      body: FutureBuilder(
        future: getUserClaims(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Card(
                    surfaceTintColor: Colors.transparent,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color(0xFF20262A),
                    shadowColor:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color(0x5467A1C5)
                            : const Color(0xFF000000),
                    clipBehavior: Clip.antiAlias,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(7),
                      childrenPadding: const EdgeInsets.all(0),
                      shape: const Border(),
                      leading: LineIcon.walking(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromRGBO(103, 161, 197, 1)
                            : const Color(0xFF394760),
                      ),
                      // contentPadding: const EdgeInsets.all(10),
                      title: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(snapshot.data!.elementAt(index).time!),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF5E5E5E)
                                  : const Color.fromRGBO(221, 221, 221, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            // "Steps Rewarded: ",
                            "Steps Rewarded: ${snapshot.data!.elementAt(index).steps_rewarded.toString()} / ${snapshot.data!.elementAt(index).steps_recorded.toString()}",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color(0xFF5E5E5E)
                                  : const Color.fromARGB(255, 141, 138, 138),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          subtitle: Text(
                            "Amount Rewarded: ${snapshot.data!.elementAt(index).amount_rewarded?.toStringAsFixed(1)}",
                            // "Amount Rewarded: ",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color(0xFF5E5E5E)
                                  : const Color.fromRGBO(221, 221, 221, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'In every walk with nature, one receives far more than he seeks.',
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
