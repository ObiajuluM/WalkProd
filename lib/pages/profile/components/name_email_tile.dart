import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:walkit/walk_it_icons.dart';

class NameandEmailTile extends ConsumerWidget {
  final String username;
  final String email;
  const NameandEmailTile({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0x5467A1C5)
          : const Color(0xFF000000),
      surfaceTintColor: Colors.transparent,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF20262A),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
        bottom: 20,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          endIndent: 70,
          indent: 70,
          height: 0,
          color: Color.fromRGBO(103, 161, 197, 0.4),
        ),
        itemBuilder: (context, index) => ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          // tileColor:
          leading: Icon(
            index == 0 ? Icons.person_outline_outlined : WalkItIcons.email,
            color: const Color(0x93E5737C),
          ),
          title: Text(
            index == 0 ? username : email,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromRGBO(143, 143, 143, 1)
                  : const Color.fromRGBO(221, 221, 221, 1),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
