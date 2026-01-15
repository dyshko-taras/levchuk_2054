import 'package:flutter/widgets.dart';

class AppRadius {
  const AppRadius._();

  static const double _pillValue = 35;
  static const double _cardValue = 14;

  static const BorderRadius pill = BorderRadius.all(
    Radius.circular(_pillValue),
  );
  static const BorderRadius card = BorderRadius.all(
    Radius.circular(_cardValue),
  );

  static const BorderRadius sm = BorderRadius.all(Radius.circular(10));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(20));
}
