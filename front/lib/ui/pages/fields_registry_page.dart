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
import '../../providers/settings_provider.dart';
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
    final args = ModalRoute.of(context)?.settings.arguments;
    final selectMode = args is FieldsRegistryArgs
        ? args.selectForResult
        : false;
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
              if (!selectMode)
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
                : _FieldsList(fields: fields, selectMode: selectMode),
          ),
        ],
      ),
    );
  }
}

class _FieldsList extends StatelessWidget {
  const _FieldsList({required this.fields, required this.selectMode});

  final List<Field> fields;
  final bool selectMode;

  Future<void> _openMoreMenu(
    BuildContext context, {
    required Field field,
  }) async {
    final canDelete = await context.read<FieldsProvider>().canDeleteField(
      field.id,
    );
    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOverlay10,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              border: Border.all(color: AppColors.whiteOverlay20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    AppStrings.fieldsRegistryMenuDeleteField,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          canDelete
                              ? AppColors.darkRed
                              : AppColors.whiteOverlay70,
                    ),
                  ),
                  onTap: canDelete
                      ? () async {
                          Navigator.of(context).pop();
                          await context.read<FieldsProvider>().deleteFieldById(
                            field.id,
                          );
                          final settings = context.read<SettingsProvider>();
                          if (settings.defaultFieldId == field.id) {
                            await settings.setDefaultFieldId(null);
                          }
                        }
                      : () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.fieldFormDeleteNotAllowed),
                            ),
                          );
                        },
                ),
                const Divider(height: 1, color: AppColors.whiteOverlay20),
                ListTile(
                  title: Text(
                    AppStrings.fieldsRegistryMenuSetAsDefault,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await context
                        .read<SettingsProvider>()
                        .setDefaultFieldId(field.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

          return Stack(
            children: [
              FieldRegistryCard(
                name: field.name,
                typeText: typeText,
                address: field.address,
                photoPath:
                    field.photoPath ?? AppImages.fieldsRegistryCardBackground,
                useForMatchLabel: AppStrings.fieldsRegistryUseForMatch,
                openLabel: AppStrings.fieldsRegistryOpen,
                onUseForMatch: selectMode
                    ? () => Navigator.of(context).pop(field.id)
                    : () => Navigator.of(context).pushNamed(
                        AppRoutes.matchComposer,
                        arguments: MatchComposerArgs(prefillFieldId: field.id),
                      ),
                onOpen: () => Navigator.of(context).pushNamed(
                  AppRoutes.fieldForm,
                  arguments: FieldFormArgs(fieldId: field.id),
                ),
              ),
              if (!selectMode)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: AppIconCircleButton(
                    icon: SvgPicture.asset(
                      AppIcons.more,
                      width: AppSizes.iconMd,
                      height: AppSizes.iconMd,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () => _openMoreMenu(context, field: field),
                  ),
                ),
            ],
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
            width: AppSizes.fieldsRegistryEmptyButtonWidth,
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

class FieldsRegistryArgs {
  const FieldsRegistryArgs({this.selectForResult = false});

  final bool selectForResult;
}
