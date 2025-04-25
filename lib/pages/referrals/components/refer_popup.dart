import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/backend/providers.dart';
import 'package:walkit/modules/backend/requests.dart';
import 'package:walkit/modules/models/backend_model.dart';

class ReferPopUp extends ConsumerStatefulWidget {
  const ReferPopUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReferPopUpState();
}

class _ReferPopUpState extends ConsumerState<ReferPopUp> {
  final inviterCodeControl = TextEditingController();

  @override
  void dispose() {
    inviterCodeControl.dispose();
    super.dispose();
  }



  getInvited(WalkUserBackend walkUser) async {
    // clean code
    final trimmedCode = inviterCodeControl.value.text.toLowerCase().trim();
    
    if (walkUser.invite_code != trimmedCode && walkUser.invited_by == null ||
        walkUser.invited_by!.isEmpty) {
      
      log("called get invited");
      try {
        await modifyUser({"invited_by": trimmedCode}).then((onValue) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } catch (e) {
        log(e.toString());
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(backendUserProvider);

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF242B2E),
      title: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          'Invited by someone?',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFF67A1C5)
                : const Color.fromRGBO(221, 221, 221, 1),
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
      content: TextField(
        controller: inviterCodeControl,
      ),
      actions: [
        Card(
          color: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFF67A1C5)
              : const Color(0xFF394861),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          surfaceTintColor: Colors.transparent,
          child: InkWell(
            radius: 15,
            onTap: () async {
              if (inviterCodeControl.text.trim().isNotEmpty) {
                // getInvited(user, globalDb, currentTheme);
                await getInvited(user);
              }
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
