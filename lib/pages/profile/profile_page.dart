import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/pages/balance/balance_page.dart';
import 'package:walkit/pages/profile/components/name_email_tile.dart';
import 'package:walkit/pages/referrals/referrals_page.dart';
import 'package:walkit/walk_it_icons.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(backendUserProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,

      ///appbar
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        toolbarHeight: 200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(56),
            bottomRight: Radius.circular(56),
          ),
        ),
        title: ListTile(
          minVerticalPadding: 50,
          title: RandomAvatar(
            user.display_name ?? "",
            height: 100,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              user.display_name ?? "",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
        ),
      ),

      ///
      body: ListView(
        children: [
          ///
          NameandEmailTile(
            username: user.display_name ?? "",
            email: user.email ?? "",
          ),

          ///
          const Divider(
            endIndent: 150,
            indent: 150,
            height: 0,
            color: Colors.white,
          ),

          ///
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => Card(
              clipBehavior: Clip.antiAlias,
              surfaceTintColor: Colors.transparent,
              shadowColor: Theme.of(context).brightness == Brightness.light
                  ? const Color(0x5467A1C5)
                  : const Color(0xFF000000),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF20262A),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
              ),

              ///
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: Icon(
                  index == 0
                      ? WalkItIcons.referrals
                      : index == 1
                          ? WalkItIcons.balance
                          : WalkItIcons.goals,
                  color: index == 0
                      ? const Color(0xFF67A1C5)
                      : index == 1
                          ? const Color(0xFF7FECB8)
                          : const Color(0xFFEFA058),
                ),
                onTap: () {
                  /// if index == 0 go to referal page
                  index == 0
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReferralsPage(),
                          ),
                        )
                      : index == 1
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const BalancePage(),
                              ),
                            )
                          : null;
                },
                title: Text(
                  index == 0
                      ? "Referrals"
                      : index == 1
                          ? "Balance"
                          : "Goal",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFF5E5E5E)
                        : const Color.fromRGBO(221, 221, 221, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
