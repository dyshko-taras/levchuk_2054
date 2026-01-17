import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/app_radius.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_spacing.dart';
import '../../theme/app_colors.dart';
import '../buttons/app_buttons.dart';

class FieldRegistryCard extends StatelessWidget {
  const FieldRegistryCard({
    super.key,
    required this.name,
    required this.useForMatchLabel,
    required this.openLabel,
    required this.typeText,
    required this.address,
    required this.photoPath,
    required this.onUseForMatch,
    required this.onOpen,
  });

  final String name;
  final String useForMatchLabel;
  final String openLabel;
  final String? typeText;
  final String? address;
  final String? photoPath;
  final VoidCallback onUseForMatch;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.xl,
      child: Container(
        height: AppSizes.fieldsRegistryCardHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteOverlay10,
          border: Border.all(color: AppColors.whiteOverlay20),
          borderRadius: AppRadius.xl,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: Insets.allMd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (typeText != null) ...[
                      Gaps.hXs,
                      Text(
                        typeText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteOverlay70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (address != null && address!.trim().isNotEmpty) ...[
                      Gaps.hXs,
                      Text(
                        address!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteOverlay70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: AppSizes.fieldsRegistryCardImageWidth,
              child: Stack(
                children: [
                  Positioned.fill(child: _FieldImage(path: photoPath)),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.darkNavy.withValues(alpha: 0.25),
                            AppColors.darkNavy.withValues(alpha: 0.70),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    bottom: AppSpacing.md,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: AppSizes.hubPillButtonHeight,
                            child: AppPillButton(
                              label: useForMatchLabel,
                              onPressed: onUseForMatch,
                              backgroundColor: AppColors.whiteOverlay10,
                            ),
                          ),
                        ),
                        Gaps.wSm,
                        Expanded(
                          child: SizedBox(
                            height: AppSizes.hubPillButtonHeight,
                            child: AppPillButton(
                              label: openLabel,
                              onPressed: onOpen,
                              backgroundColor: AppColors.whiteOverlay10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldImage extends StatelessWidget {
  const _FieldImage({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    if (path == null || path.trim().isEmpty) {
      return const ColoredBox(color: AppColors.whiteOverlay10);
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const ColoredBox(color: AppColors.whiteOverlay10),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const ColoredBox(color: AppColors.whiteOverlay10),
    );
  }
}
