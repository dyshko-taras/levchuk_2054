import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/fields/field_registry_card.dart';
import 'field_form_page.dart';
import 'match_composer_page.dart';

class FieldsRegistryPage extends StatelessWidget {
  const FieldsRegistryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ColoredBox(
        color: AppColors.darkNavy,
        child: SafeArea(child: _Body()),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final fields = context.watch<FieldsProvider>().fields;

    return Padding(
      padding: Insets.allMd,
      child: Column(
        children: [
          Row(
            children: [
              AppTopBarTextButton(
                label: AppStrings.fieldsRegistryTitle,
                onPressed: () => Navigator.of(context).maybePop(),
                leading: SvgPicture.asset(
                  AppIcons.back,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const Spacer(),
              AppIconCircleButton(
                icon: SvgPicture.asset(
                  AppIcons.add,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.fieldForm,
                  arguments: const FieldFormArgs(createNew: true),
                ),
              ),
            ],
          ),
          Gaps.hMd,
          Expanded(
            child: fields.isEmpty
                ? _EmptyState(
                    onCreate: () => Navigator.of(context).pushNamed(
                      AppRoutes.fieldForm,
                      arguments: const FieldFormArgs(createNew: true),
                    ),
                  )
                : _FieldsList(fields: fields),
          ),
        ],
      ),
    );
  }
}

class _FieldsList extends StatelessWidget {
  const _FieldsList({required this.fields});

  final List<Field> fields;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: ListView.separated(
        itemCount: fields.length,
        separatorBuilder: (_, __) => Gaps.hSm,
        itemBuilder: (context, index) {
          final field = fields[index];
          final typeText = field.type == null
              ? null
              : '${AppStrings.fieldsRegistryTypePrefix} ${field.type}';

          return FieldRegistryCard(
            name: field.name,
            typeText: typeText,
            address: field.address,
            photoPath:
                field.photoPath ?? AppImages.fieldsRegistryCardBackground,
            useForMatchLabel: AppStrings.fieldsRegistryUseForMatch,
            openLabel: AppStrings.fieldsRegistryOpen,
            onUseForMatch: () => Navigator.of(context).pushNamed(
              AppRoutes.matchComposer,
              arguments: MatchComposerArgs(prefillFieldId: field.id),
            ),
            onOpen: () => Navigator.of(context).pushNamed(
              AppRoutes.fieldForm,
              arguments: FieldFormArgs(fieldId: field.id),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.fieldsRegistryEmpty,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gaps.hMd,
          SizedBox(
            width: 200,
            child: AppPrimaryButton(
              label: AppStrings.fieldsRegistryNewField,
              onPressed: onCreate,
            ),
          ),
        ],
      ),
    );
  }
}
