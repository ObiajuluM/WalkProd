
import 'package:riverpod/riverpod.dart';

class Greeting extends StateNotifier<String> {
  Greeting() : super("Good Day!");

  void greet() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      state = 'Good Morning!';
    } else if (hour < 17) {
      state = 'Good Afternoon!';
    } else {
      state = 'Good Evening!';
    }
  }
}

final greetingProvider = StateNotifierProvider<Greeting, String>((ref) {
  return Greeting();
});