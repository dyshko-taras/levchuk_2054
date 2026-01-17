import 'package:flutter/material.dart';

import '../../../constants/app_radius.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_spacing.dart';
import '../../theme/app_colors.dart';

class QuickBarItem {
  const QuickBarItem({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.trailing,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final Widget? trailing;
}

class QuickBar extends StatelessWidget {
  const QuickBar({super.key, required this.items});

  final List<QuickBarItem> items;

  @override
  Widget build(BuildContext context) {
    final shouldScroll = items.length > 3;
    return Container(
      height: AppSizes.hubQuickBarHeight,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: shouldScroll ? _Scrollable(items: items) : _Expanded(items: items),
    );
  }
}

class _Expanded extends StatelessWidget {
  const _Expanded({required this.items});

  final List<QuickBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final item in items)
          Expanded(
            child: Padding(
              padding: Insets.allXs,
              child: _QuickBarButton(item: item),
            ),
          ),
      ],
    );
  }
}

class _Scrollable extends StatelessWidget {
  const _Scrollable({required this.items});

  final List<QuickBarItem> items;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.lg,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: Insets.allXs,
        child: Row(
          children: [
            for (final item in items) ...[
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: AppSizes.hubQuickBarItemMinWidth,
                ),
                child: _QuickBarButton(item: item),
              ),
              if (item != items.last) Gaps.wSm,
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickBarButton extends StatelessWidget {
  const _QuickBarButton({required this.item});

  final QuickBarItem item;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: item.isSelected
            ? AppColors.primaryBlue
            : AppColors.whiteOverlay20,
        shape: const StadiumBorder(),
        padding: EdgeInsets.zero,
      ),
      onPressed: item.onPressed,
      child: item.trailing == null
          ? Text(
              item.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.wXs,
                item.trailing!,
              ],
            ),
    );
  }
}
