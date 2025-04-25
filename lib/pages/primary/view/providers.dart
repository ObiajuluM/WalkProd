import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryPageIndex extends StateNotifier<int> {
  PrimaryPageIndex() : super(0);

  setIndex(int index) {
    state = index;
  }
}

final primaryPageIndexProvider =
    StateNotifierProvider<PrimaryPageIndex, int>((ref) {
  return PrimaryPageIndex();
});
