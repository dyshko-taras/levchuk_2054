import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_radius.dart';
import '../../../constants/app_spacing.dart';
import '../../theme/app_colors.dart';

class KitPreview extends StatelessWidget {
  const KitPreview({
    super.key,
    required this.primary,
    required this.secondary,
  });

  final Color primary;
  final Color secondary;

  static const String _primaryPlaceholder = '#FF0000';
  static const String _secondaryPlaceholder = '#0000FF';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.card,
      child: Container(
        color: AppColors.whiteOverlay10,
        padding: Insets.allSm,
        child: FutureBuilder<String>(
          future: _loadAndTintSvg(
            assetPath: AppImages.kitTemplateDefault,
            primary: primary,
            secondary: secondary,
          ),
          builder: (context, snapshot) {
            final svg = snapshot.data;
            if (svg == null) {
              return const SizedBox(
                width: 64,
                height: 64,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.whiteOverlay10),
                ),
              );
            }

            return SvgPicture.string(
              svg,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }

  Future<String> _loadAndTintSvg({
    required String assetPath,
    required Color primary,
    required Color secondary,
  }) async {
    final raw = await rootBundle.loadString(assetPath);
    return raw
        .replaceAll(_primaryPlaceholder, _toHex(primary))
        .replaceAll(_secondaryPlaceholder, _toHex(secondary));
  }

  String _toHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}
