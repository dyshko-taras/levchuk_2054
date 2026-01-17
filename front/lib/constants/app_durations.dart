class AppDurations {
  const AppDurations._();

  static const splashMin = Duration(seconds: 5);
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);

  static const matchDefault = Duration(minutes: 90);
  static const matchBufferAfter = Duration(minutes: 10);
  static const availabilitySlot = Duration(hours: 1);
}
