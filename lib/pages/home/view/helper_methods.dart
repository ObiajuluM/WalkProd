/// get percentage of steps taken to goal
double goalPercent(int steps, int goal) {
  final gDouble = steps / goal;
  return gDouble >= 1 ? 1 : double.parse(gDouble.toStringAsFixed(2));
}