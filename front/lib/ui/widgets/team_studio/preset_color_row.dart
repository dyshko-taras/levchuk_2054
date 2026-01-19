import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../constants/app_radius.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../buttons/app_buttons.dart';

class PresetColorRow extends StatelessWidget {
  const PresetColorRow({
    super.key,
    required this.primary,
    required this.secondary,
    required this.onPrimaryChanged,
    required this.onSecondaryChanged,
  });

  final Color primary;
  final Color secondary;
  final ValueChanged<Color> onPrimaryChanged;
  final ValueChanged<Color> onSecondaryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.allSm,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.pill,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ColorDot(
            color: primary,
            onTap: () => _pickColor(
              context: context,
              initial: primary,
              onChanged: onPrimaryChanged,
            ),
          ),
          Gaps.wSm,
          _ColorDot(
            color: secondary,
            onTap: () => _pickColor(
              context: context,
              initial: secondary,
              onChanged: onSecondaryChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickColor({
    required BuildContext context,
    required Color initial,
    required ValueChanged<Color> onChanged,
  }) async {
    var temp = initial;
    var confirmed = false;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.darkNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            side: const BorderSide(color: AppColors.whiteOverlay20),
          ),
          child: Padding(
            padding: Insets.allMd,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.teamStudioColorPickerTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.hMd,
                  ColorPicker(
                    pickerColor: initial,
                    onColorChanged: (c) => temp = c,
                    enableAlpha: false,
                    displayThumbColor: true,
                    labelTypes: const [],
                    paletteType: PaletteType.hsl,
                  ),
                  Gaps.hMd,
                  Row(
                    children: [
                      Expanded(
                        child: AppSecondaryButton(
                          label: AppStrings.commonCancel,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Gaps.wSm,
                      Expanded(
                        child: AppPrimaryButton(
                          label: AppStrings.commonOk,
                          onPressed: () {
                            confirmed = true;
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (confirmed) onChanged(temp);
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.pill,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
      ),
    );
  }
}
