import 'package:flutter/widgets.dart';

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 7;
  static const double md = 13;
  static const double lg = 18;
  static const double xl = 25;
}

class Insets {
  const Insets._();

  static const EdgeInsets allXs = EdgeInsets.all(AppSpacing.xs);
  static const EdgeInsets allSm = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets allMd = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets allLg = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets allXl = EdgeInsets.all(AppSpacing.xl);

  static const EdgeInsets hMd = EdgeInsets.symmetric(horizontal: AppSpacing.md);
  static const EdgeInsets vMd = EdgeInsets.symmetric(vertical: AppSpacing.md);
}

class Gaps {
  const Gaps._();

  static const SizedBox hXs = SizedBox(height: AppSpacing.xs);
  static const SizedBox hSm = SizedBox(height: AppSpacing.sm);
  static const SizedBox hMd = SizedBox(height: AppSpacing.md);
  static const SizedBox hLg = SizedBox(height: AppSpacing.lg);
  static const SizedBox hXl = SizedBox(height: AppSpacing.xl);

  static const SizedBox wXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox wSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox wMd = SizedBox(width: AppSpacing.md);
  static const SizedBox wLg = SizedBox(width: AppSpacing.lg);
  static const SizedBox wXl = SizedBox(width: AppSpacing.xl);
}

extension NumSpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
