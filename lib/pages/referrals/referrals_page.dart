import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icon.dart';

import 'package:random_avatar/random_avatar.dart';
import 'package:walkit/global/components/medium_app_bar.dart';
import 'package:walkit/global/helper_methods.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/modules/backend/requests.dart';
import 'package:walkit/pages/referrals/components/refer_popup.dart';

class ReferralsPage extends ConsumerStatefulWidget {
  const ReferralsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends ConsumerState<ReferralsPage> {
  /// get the user invite count
  String inviteCountify(int count) {
    // int count = 0;
    // getUserInvites().then((onValue) {
    //   count = onValue.length;
    // });

    final ncount = "0$count";
    return count > 9 && count <= 99
        ? ncount
        : count <= 10
            ? "00$count"
            : "$count";
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(backendUserProvider);

    // final displayName = "AdamantPotato";
    // final inviteCode = "c5ryi";
    // final invitedBy = null;
    //
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: CustomMediumAppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFF67A1C5)
            : const Color(0xFF394861),

        ///
        title: "Referrals",

        /// actions: top right
        actions: [
          user.invited_by == null || user.invited_by!.isEmpty
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ReferPopUp(),
                    );
                  },
                  child: LineIcon.wiredNetwork(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color.fromRGBO(34, 40, 43, 1),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color(0xFF67A1C5)
                                : const Color(0xFF394861),
                        content: Text(
                          "Invited by ${user.invited_by}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : const Color.fromRGBO(221, 221, 221, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const LineIcon.plusSquare(
                    color: Colors.black,
                  ),
                ),
        ],

        /// content
        content: ListTile(
          title: Center(
            child: FutureBuilder(
                future: getUserInvites(),
                builder: (context, snapshot) {
                  final count = snapshot.data?.length ?? 0;
                  return Text(
                    inviteCountify(count),
                    maxLines: 1,
                    // semanticsLabel: "100,000",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color.fromRGBO(221, 221, 221, 1),
                      fontSize: 96,
                      fontFamily: "EvilEmpire",
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -3.84,
                    ),
                  );
                }),
          ),
        ),

        ///
        footer: Card(
          clipBehavior: Clip.antiAlias,
          color: const Color(0xFF85B4D1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            // tileColor: Color(0xFF85B4D1),
            leading: SizedBox(
              height: 60,
              width: 60,
              child: RandomAvatar(user.display_name ?? ""),
            ),
            title: Text(
              user.display_name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF394861),
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            subtitle: Text(
              user.invite_code ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.50,
              ),
            ),
            trailing: InkWell(
              onTap: () {
                shareText(
                  message:
                      'Hi, I am inviting you to Walk It. A web3 app that rewards you to walk - Use my code ${user.invite_code} after you sign up to receive a bonus',
                  subject: "Walk It Invite",
                );
              },
              child: Container(
                width: 54,
                height: 60,
                padding: const EdgeInsets.all(13),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF22282B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Icon(
                  Icons.copy,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : const Color.fromRGBO(221, 221, 221, 1),
                ),
              ),
            ),
          ),
        ),
      ),

      ///
      body: FutureBuilder(
        future: getUserInvites(),
        builder: (context, snapshot) {



          return snapshot.hasData && snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: RandomAvatar(
                        snapshot.data!.elementAt(index).display_name ?? "",
                        height: 34,
                        width: 34,
                      ),
                      title: Text(
                        snapshot.data!.elementAt(index).display_name ?? "",
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
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "Don't walk in front of me… I may not follow, Don't walk behind me… I may not lead, Walk beside me… just be my friend",
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
