import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// appbar for referals and balance
class CustomMediumAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Widget content;
  final Widget footer;
  final Color backgroundColor;

  final List<Widget>? actions;

  const CustomMediumAppBar({
    super.key,
    required this.title,
    required this.content,
    required this.footer,
    required this.backgroundColor,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(319);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentTheme = ref.watch(ThemeModeStateProvider);
    // final user = ref.watch(userProvider);
    // final backendUser = {};
    // final displayName = "Adamanto Potato";
    // final inviteCode = "ewebwk";
    // final invitedBy = "ebwejkbw";
    // final userInvites = ref.watch(invitesProvider);

    // Map<String, dynamic> cleanUserInvites = userInvites.remove('owner');

    ///
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34),
            ),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              ///
              AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                centerTitle: true,
                leading: BackButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF22282B),
                ),
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color.fromRGBO(221, 221, 221, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                actions: actions,
              ),

              ///
              content,

              const Spacer(),

              ///
              footer,
            ],
          ),
        ),

        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: double.infinity,
              color: Colors.white.withOpacity(0.1),
              width: 21,
              margin: const EdgeInsets.symmetric(horizontal: 21),
            ),
            Container(
              height: double.infinity,
              color: Colors.white.withOpacity(0.1),
              width: 21,
              // margin: EdgeInsets.symmetric(horizontal: 15),
            ),
            Container(
              height: double.infinity,
              color: Colors.white.withOpacity(0.1),
              width: 21,
              margin: const EdgeInsets.only(
                left: 21,
                right: 100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
