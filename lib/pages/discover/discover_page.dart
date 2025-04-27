import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: Theme.of(context).brightness == Brightness.light
                ? [
                    Color.fromRGBO(65, 115, 243, 1),
                    const Color.fromRGBO(112, 172, 185, 1),
                    const Color.fromRGBO(241, 109, 117, 1),
                  ]
                : [
                    const Color(0xFF1B326B),
                    const Color(0xFF33535A),
                    const Color(0xFF531317),
                  ],
          ),
        ),
        child: const Text(
          'Coming\nsoon...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
