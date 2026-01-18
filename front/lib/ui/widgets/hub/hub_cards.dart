import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_radius.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../buttons/app_buttons.dart';

class NextMatchCard extends StatelessWidget {
  const NextMatchCard({
    super.key,
    required this.matchDateTime,
    required this.matchFieldName,
    required this.statusLabel,
    required this.isFinished,
    required this.onOpen,
    required this.onAddMatch,
  });

  final String? matchDateTime;
  final String? matchFieldName;
  final String? statusLabel;
  final bool isFinished;
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
              statusLabel: statusLabel ?? AppStrings.commonPlaceholderDash,
              isFinished: isFinished,
            )
          : _NoMatchContent(onAddMatch: onAddMatch),
    );
  }
}

class DefaultTeamCard extends StatelessWidget {
  const DefaultTeamCard({
    super.key,
    required this.teamName,
    required this.playersCount,
    required this.onOpen,
    required this.onLineup,
  });

  final String? teamName;
  final int? playersCount;
  final VoidCallback onOpen;
  final VoidCallback onLineup;

  @override
  Widget build(BuildContext context) {
    return _HubCard(
      background: AppImages.hubMySquadCardBackground,
      child: teamName == null
          ? _EmptyCtaContent(
              text: AppStrings.hubEmptyNoDefaultTeam,
              ctaLabel: AppStrings.teamsDirectoryNewTeam,
              onPressed: onOpen,
            )
          : Padding(
              padding: Insets.allMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.hXs,
                  Text(
                    AppStrings.hubLabelPlayersCount(playersCount ?? 0),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteOverlay70,
                    ),
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

class DefaultFieldCard extends StatelessWidget {
  const DefaultFieldCard({
    super.key,
    required this.fieldName,
    required this.fieldSubtitle,
    required this.onOpen,
  });

  final String? fieldName;
  final String? fieldSubtitle;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return _HubCard(
      background: AppImages.hubFieldSnapshotCardBackground,
      child: fieldName == null
          ? _EmptyCtaContent(
              text: AppStrings.hubEmptyNoDefaultField,
              ctaLabel: AppStrings.fieldsRegistryNewField,
              onPressed: onOpen,
            )
          : Padding(
              padding: Insets.allMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.hXs,
                  Text(
                    fieldSubtitle ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteOverlay70,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: AppSizes.hubOpenButtonWidth,
                      height: AppSizes.hubPillButtonHeight,
                      child: AppPillButton(
                        label: AppStrings.hubActionOpen,
                        onPressed: onOpen,
                        backgroundColor: AppColors.whiteOverlay10,
                      ),
                    ),
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
    required this.statusLabel,
    required this.isFinished,
  });

  final VoidCallback onOpen;
  final String? dateTimeText;
  final String? fieldNameText;
  final String statusLabel;
  final bool isFinished;

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
                border: Border.all(
                  color: isFinished
                      ? AppColors.statsScheduled
                      : AppColors.limeGreen,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: AppSizes.hubStatusDotSize,
                    width: AppSizes.hubStatusDotSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  Gaps.wSm,
                  Text(
                    statusLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
            width: AppSizes.hubEmptyCtaWidth,
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

class _EmptyCtaContent extends StatelessWidget {
  const _EmptyCtaContent({
    required this.text,
    required this.ctaLabel,
    required this.onPressed,
  });

  final String text;
  final String ctaLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.allMd,
      child: Column(
        children: [
          const Spacer(),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Gaps.hMd,
          SizedBox(
            width: AppSizes.hubEmptyCtaWidth,
            height: AppSizes.hubPillButtonHeight,
            child: AppPillButton(
              label: ctaLabel,
              onPressed: onPressed,
              backgroundColor: AppColors.whiteOverlay10,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
