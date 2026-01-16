import 'package:flutter/material.dart';

import '../../../constants/app_radius.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../buttons/app_buttons.dart';

class NextMatchCard extends StatelessWidget {
  const NextMatchCard({
    super.key,
    required this.matchDateTime,
    required this.matchFieldName,
    required this.onOpen,
    required this.onAddMatch,
  });

  final String? matchDateTime;
  final String? matchFieldName;
  final VoidCallback onOpen;
  final VoidCallback onAddMatch;

  @override
  Widget build(BuildContext context) {
    final hasMatch = matchDateTime != null || matchFieldName != null;
    return _HubCard(
      background: hasMatch
          ? AppImages.hubNextMatchCardBackground
          : AppImages.hubNoMatchPlannedCardBackground,
      child: hasMatch
          ? _NextMatchContent(
              onOpen: onOpen,
              dateTimeText: matchDateTime,
              fieldNameText: matchFieldName,
            )
          : _NoMatchContent(onAddMatch: onAddMatch),
    );
  }
}

class MySquadCard extends StatelessWidget {
  const MySquadCard({
    super.key,
    required this.teamName,
    required this.playersCount,
    required this.onOpen,
    required this.onLineup,
  });

  final String teamName;
  final int playersCount;
  final VoidCallback onOpen;
  final VoidCallback onLineup;

  @override
  Widget build(BuildContext context) {
    return _HubCard(
      background: AppImages.hubMySquadCardBackground,
      child: Padding(
        padding: Insets.allMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              teamName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.hXs,
            Text(
              AppStrings.hubLabelPlayersCount(playersCount),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.whiteOverlay70),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppPillButton(
                    label: AppStrings.hubActionOpen,
                    onPressed: onOpen,
                    backgroundColor: AppColors.whiteOverlay10,
                  ),
                ),
                Gaps.wSm,
                Expanded(
                  child: AppPillButton(
                    label: AppStrings.hubActionLineup,
                    onPressed: onLineup,
                    backgroundColor: AppColors.whiteOverlay10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FieldsSnapshotCard extends StatelessWidget {
  const FieldsSnapshotCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onOpen,
  });

  final String title;
  final String subtitle;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return _HubCard(
      background: AppImages.hubFieldSnapshotCardBackground,
      child: Padding(
        padding: Insets.allMd,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Gaps.hXs,
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteOverlay70,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.wSm,
            SizedBox(
              height: AppSizes.hubPillButtonHeight,
              child: AppPillButton(
                label: AppStrings.hubActionOpen,
                onPressed: onOpen,
                backgroundColor: AppColors.whiteOverlay10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  const _HubCard({required this.background, required this.child});

  final String background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.card,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(background, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: AppColors.darkNavy.withValues(alpha: 0.35)),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkNavy.withValues(alpha: 0.15),
                    AppColors.darkNavy.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _NextMatchContent extends StatelessWidget {
  const _NextMatchContent({
    required this.onOpen,
    required this.dateTimeText,
    required this.fieldNameText,
  });

  final VoidCallback onOpen;
  final String? dateTimeText;
  final String? fieldNameText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.allMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: AppSizes.hubStatusChipHeight,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.whiteOverlay10,
                borderRadius: AppRadius.pill,
                border: Border.all(color: AppColors.whiteOverlay20),
              ),
              alignment: Alignment.center,
              child: Text(
                AppStrings.hubChipStatus,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Spacer(),
          if (dateTimeText != null) ...[
            Text(
              dateTimeText!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gaps.hXs,
          ],
          if (fieldNameText != null)
            Text(
              fieldNameText!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.whiteOverlay70),
            ),
          Gaps.hSm,
          SizedBox(
            width: AppSizes.hubOpenButtonWidth,
            height: AppSizes.hubPillButtonHeight,
            child: AppPillButton(
              label: AppStrings.hubActionOpen,
              onPressed: onOpen,
              backgroundColor: AppColors.whiteOverlay10,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoMatchContent extends StatelessWidget {
  const _NoMatchContent({required this.onAddMatch});

  final VoidCallback onAddMatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.allMd,
      child: Column(
        children: [
          const Spacer(),
          Text(
            AppStrings.hubEmptyNoMatchPlanned,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Gaps.hMd,
          SizedBox(
            width: AppSizes.hubEmptyCtaWidth,
            height: AppSizes.hubPillButtonHeight,
            child: AppPillButton(
              label: AppStrings.hubCtaAddMatch,
              onPressed: onAddMatch,
              backgroundColor: AppColors.whiteOverlay10,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
