import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:walkit/global/helper_methods.dart';

class SocialsPopup extends ConsumerWidget {
  final String twitter;
  final String telegram;
  final String website;

  const SocialsPopup({
    super.key,
    required this.twitter,
    required this.telegram,
    required this.website,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => ListTile(
        onTap: () async {
          index == 0
              ? launchIt(twitter)
              : index == 1
                  ? launchIt(website)
                  : launchIt(telegram);
        },
        leading: index == 0
            ? LineIcon.twitter(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.blue
                    : Colors.white,
              )
            : index == 1
                ? LineIcon.globeWithAfricaShown(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.blueAccent
                        : Colors.blue,
                  )
                : LineIcon.telegram(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.blue
                        : Colors.white,
                  ),
        title: Text(
          index == 0
              ? "X"
              : index == 1
                  ? "Website"
                  : "Telegram",
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
    );
  }
}
