import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_durations.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../providers/settings_provider.dart';
import '../theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
  }

  Future<void> _boot() async {
    if (_navigated) return;

    final startedAt = DateTime.now();
    try {
      final settings = context.read<SettingsProvider>();
      final targetRoute =
          settings.isFirstLaunch ? AppRoutes.onboarding : AppRoutes.hub;

      final elapsed = DateTime.now().difference(startedAt);
      final remaining = AppDurations.splashMin - elapsed;
      if (remaining > Duration.zero) {
        await Future<void>.delayed(remaining);
      }

      if (!mounted || _navigated) return;
      _navigated = true;
      await Navigator.of(context).pushReplacementNamed(targetRoute);
    } catch (_) {
      final elapsed = DateTime.now().difference(startedAt);
      final remaining = AppDurations.splashMin - elapsed;
      if (remaining > Duration.zero) {
        await Future<void>.delayed(remaining);
      }

      if (!mounted || _navigated) return;
      _navigated = true;
      await Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.displayLarge;
    final taglineStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.whiteOverlay70,
        );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.splashBackground,
            fit: BoxFit.cover,
          ),
          Container(color: AppColors.darkNavy.withValues(alpha: 0.55)),
          Center(
            child: Padding(
              padding: Insets.hMd,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.splashTitle,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Gaps.hSm,
                  Text(
                    AppStrings.splashTagline,
                    style: taglineStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
