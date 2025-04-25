import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/pages/home/components/explore.dart';
import 'package:walkit/pages/home/components/home_app_bar.dart';
import 'package:walkit/pages/home/components/leaderboard.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,

      ///
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///
            HomeAppBar(),

            ///
            Explore(),

            //
            Leaderboard(),
          ],
        ),
      ),
    );
  }
}
