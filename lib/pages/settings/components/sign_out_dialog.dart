import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walkit/global/constants.dart';
import 'package:walkit/modules/auth/access_token_handling.dart';
import 'package:walkit/modules/auth/authentication.dart';

import 'package:walkit/pages/primary/view/providers.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  Future<void> signOut() async {
    final accessToken = await retrieveAccessTokenFromLocal();
    await WalkItBackendAuth().signOut(
        accessToken!,
        kDjangoClientID,
        "$kbaseURL/auth/invalidate-sessions/",
        "$kbaseURL/auth/invalidate-refresh-tokens/");

    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF242B2E),
      actionsAlignment: MainAxisAlignment.center,
      title: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: const Text(
          'You are about to sign out!',
          style: TextStyle(
            color: Color(0xFFE9222E),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        trailing: CloseButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFF67A1C5)
                : const Color(0xFF394861),
            foregroundColor: Colors.white,
          ),
        ),
      ),

      ///
      content: Text(
        "Thanks for walking with us! See you later, Walker! Don't forget to lace up those shoes tomorrow.",
        // textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
      actions: [
        Card(
          color: const Color(0xFFF16D75),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          surfaceTintColor: Colors.transparent,
          child: InkWell(
            radius: 15,
            onTap: () {
              ref.read(primaryPageIndexProvider.notifier).setIndex(0);

              signOut().then((value) {
                Navigator.of(context).pop();
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 20,
              ),
              child: Text(
                "Ok",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
