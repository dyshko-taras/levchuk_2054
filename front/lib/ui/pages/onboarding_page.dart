import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_durations.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../providers/settings_provider.dart';
import '../privacy/privacy_actions.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _index = 0;
  bool _busy = false;

  static const List<_SlideData> _slides = [
    _SlideData(
      image: AppImages.onboardingSlideTeamStudio,
      title: AppStrings.onboardingSlide1Title,
      subtitle: AppStrings.onboardingSlide1Subtitle,
    ),
    _SlideData(
      image: AppImages.onboardingSlideFieldsRegistry,
      title: AppStrings.onboardingSlide2Title,
      subtitle: AppStrings.onboardingSlide2Subtitle,
    ),
    _SlideData(
      image: AppImages.onboardingSlideAvailability,
      title: AppStrings.onboardingSlide3Title,
      subtitle: AppStrings.onboardingSlide3Subtitle,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _goTo(int index) async {
    await _controller.animateToPage(
      index,
      duration: AppDurations.normal,
      curve: Curves.easeOut,
    );
  }

  Future<void> _next() async {
    if (_busy) return;

    if (_index < 2) {
      await _goTo(_index + 1);
      return;
    }

    setState(() => _busy = true);
    await context.read<SettingsProvider>().setFirstLaunchCompleted();
    if (!mounted) return;
    await Navigator.of(context).pushReplacementNamed(AppRoutes.hub);
  }

  Future<void> _back() async {
    if (_index <= 0) return;
    await _goTo(_index - 1);
  }

  Future<void> _skip() async => _goTo(2);

  Future<void> _openPrivacy() async {
    await openPrivacy(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == 2;
    final slide = _slides[_index];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.onboardingBackground, fit: BoxFit.cover),
          Container(color: AppColors.darkNavy.withValues(alpha: 0.55)),
          PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _index = value),
            children: _slides
                .map((s) => _OnboardingSlideBackground(image: s.image))
                .toList(growable: false),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: Insets.allMd,
                  child: _TopBar(
                    showBack: _index > 0,
                    onBack: _back,
                    onSkip: _skip,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Insets.allMd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slide.title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Gaps.hSm,
                      Text(
                        slide.subtitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.whiteOverlay70),
                      ),
                      Gaps.hLg,
                      Center(child: _Dots(activeIndex: _index)),
                      Gaps.hLg,
                      AppPrimaryButton(
                        label: AppStrings.onboardingNext,
                        onPressed: _next,
                      ),
                      if (isLast) ...[
                        Gaps.hMd,
                        AppSecondaryButton(
                          label: AppStrings.onboardingPrivacy,
                          onPressed: _openPrivacy,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.showBack,
    required this.onBack,
    required this.onSkip,
  });

  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          AppTopBarTextButton(
            label: AppStrings.onboardingBack,
            onPressed: onBack,
            leading: SvgPicture.asset(
              AppIcons.back,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        const Spacer(),
        AppTopBarTextButton(
          label: AppStrings.onboardingSkip,
          onPressed: onSkip,
        ),
      ],
    );
  }
}

class _OnboardingSlideBackground extends StatelessWidget {
  const _OnboardingSlideBackground({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: Image.asset(
            image,
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            fit: BoxFit.contain,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: AppSizes.onboardingBottomFadeHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0),
                  Colors.black.withValues(alpha: 0.8),
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (i) {
        final active = i == activeIndex;
        return Container(
          width: AppSizes.onboardingDotsSize,
          height: AppSizes.onboardingDotsSize,
          margin: EdgeInsets.only(
            right: i == 2 ? 0 : AppSizes.onboardingDotsGap,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.white : AppColors.whiteOverlay20,
          ),
        );
      }),
    );
  }
}

class _SlideData {
  const _SlideData({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}
