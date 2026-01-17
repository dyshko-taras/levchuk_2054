import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_icons.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_spacing.dart';
import '../../theme/app_colors.dart';

class AppPillTextField extends StatelessWidget {
  const AppPillTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixIconAsset = AppIcons.edit,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? suffixIconAsset;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintText == null
            ? null
            : Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(
                color: AppColors.whiteOverlay70,
              ),
        filled: true,
        fillColor: AppColors.whiteOverlay10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        suffixIcon: suffixIconAsset == null
            ? null
            : SvgPicture.asset(
                suffixIconAsset!,
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
              ),
        suffixIconConstraints: suffixIconAsset == null
            ? null
            : const BoxConstraints(
                minHeight: AppSizes.iconMd,
                minWidth: AppSizes.iconMd + AppSpacing.xl,
              ),
      ),
    );
  }
}

class AppTextAreaField extends StatelessWidget {
  const AppTextAreaField({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixIconAsset = AppIcons.edit,
    this.maxLines = 4,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? suffixIconAsset;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      enabled: enabled,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintText == null
            ? null
            : Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(
                color: AppColors.whiteOverlay70,
              ),
        filled: true,
        fillColor: AppColors.whiteOverlay10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        suffixIcon: suffixIconAsset == null
            ? null
            : SvgPicture.asset(
                suffixIconAsset!,
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
              ),
        suffixIconConstraints: suffixIconAsset == null
            ? null
            : const BoxConstraints(
                minHeight: AppSizes.iconMd,
                minWidth: AppSizes.iconMd + AppSpacing.xl,
              ),
      ),
    );
  }
}
