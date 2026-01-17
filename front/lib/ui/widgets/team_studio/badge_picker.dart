import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_radius.dart';
import '../../../constants/app_spacing.dart';
import '../../theme/app_colors.dart';

class BadgePicker extends StatelessWidget {
  const BadgePicker({
    super.key,
    required this.selectedAsset,
    required this.onSelect,
  });

  final String? selectedAsset;
  final ValueChanged<String> onSelect;

  static const int _columns = 6;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.card,
      child: GridView.builder(
        padding: Insets.allXs,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columns,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
        ),
        itemCount: AppImages.teamBadges.length,
        itemBuilder: (context, index) {
          final asset = AppImages.teamBadges[index];
          final selected = selectedAsset == asset;
          return _BadgeCell(
            asset: asset,
            selected: selected,
            onTap: () => onSelect(asset),
          );
        },
      ),
    );
  }
}

class _BadgeCell extends StatelessWidget {
  const _BadgeCell({
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteOverlay10,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: Insets.allXs,
          decoration: BoxDecoration(
            borderRadius: AppRadius.sm,
            border: selected
                ? Border.all(color: AppColors.limeGreen, width: 2)
                : Border.all(color: Colors.transparent),
          ),
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
