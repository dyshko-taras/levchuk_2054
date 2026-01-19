import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_config.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../../utils/app_version.dart';
import '../privacy/privacy_actions.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final teams = context.watch<TeamsProvider>().teams;
    final fields = context.watch<FieldsProvider>().fields;

    final defaultTeamName = settings.defaultTeamId == null
        ? AppStrings.settingsDefaultTeamNone
        : teams
                  .where((t) => t.id == settings.defaultTeamId)
                  .map((t) => t.name)
                  .cast<String?>()
                  .firstWhere((t) => t != null, orElse: () => null) ??
              AppStrings.settingsDefaultTeamNone;

    final defaultFieldName = settings.defaultFieldId == null
        ? AppStrings.settingsDefaultFieldNone
        : fields
                  .where((f) => f.id == settings.defaultFieldId)
                  .map((f) => f.name)
                  .cast<String?>()
                  .firstWhere((f) => f != null, orElse: () => null) ??
              AppStrings.settingsDefaultFieldNone;

    return Scaffold(
      body: ColoredBox(
        color: AppColors.darkNavy,
        child: SafeArea(
          child: Padding(
            padding: Insets.allMd,
            child: Column(
              children: [
                Row(
                  children: [
                    AppTopBarTextButton(
                      label: AppStrings.settingsHeaderTitle,
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
                  ],
                ),
                Gaps.hMd,
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionTitle(
                        text: AppStrings.settingsSectionDefaults,
                      ),
                      Gaps.hSm,
                      _RowButton(
                        label: AppStrings.settingsRowDefaultTeam,
                        trailingText: defaultTeamName,
                        onTap: () async {
                          final selectedId = await _pickDefaultTeamId(
                            context,
                            teams: teams,
                            currentId: settings.defaultTeamId,
                          );
                          if (selectedId == null) return;
                          if (selectedId == 0) {
                            await context
                                .read<TeamsProvider>()
                                .clearDefaultTeamFlag();
                            await settings.setDefaultTeamId(null);
                            return;
                          }
                          await settings.setDefaultTeamId(selectedId);
                          await context
                              .read<TeamsProvider>()
                              .setDefaultTeamFlag(selectedId);
                        },
                      ),
                      Gaps.hSm,
                      _RowButton(
                        label: AppStrings.settingsRowDefaultField,
                        trailingText: defaultFieldName,
                        onTap: () async {
                          final selectedId = await _pickDefaultFieldId(
                            context,
                            fields: fields,
                            currentId: settings.defaultFieldId,
                          );
                          if (selectedId == null) return;
                          if (selectedId == 0) {
                            await settings.setDefaultFieldId(null);
                            return;
                          }
                          await settings.setDefaultFieldId(selectedId);
                        },
                      ),
                      Gaps.hMd,
                      const _SectionTitle(
                        text: AppStrings.settingsSectionNotifications,
                      ),
                      Gaps.hSm,
                      _RowSwitch(
                        label: AppStrings.settingsRowLocalMatchReminders,
                        value: settings.localRemindersEnabled,
                        onChanged: (value) =>
                            settings.setLocalRemindersEnabled(value),
                      ),
                      Gaps.hMd,
                      const _SectionTitle(
                        text: AppStrings.settingsSectionAbout,
                      ),
                      Gaps.hSm,
                      FutureBuilder<String>(
                        future: AppVersion.load(),
                        builder: (context, snapshot) {
                          final versionText =
                              snapshot.data ?? AppStrings.commonPlaceholderDash;
                          return _RowButton(
                            label: AppStrings.settingsRowVersion,
                            trailingText: versionText,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(versionText)),
                              );
                            },
                          );
                        },
                      ),
                      Gaps.hSm,

                      FutureBuilder<String>(
                        future: AppVersion.load(),
                        builder: (context, snapshot) {
                          final versionText =
                              snapshot.data ?? AppStrings.commonPlaceholderDash;
                          return _RowButton(
                            label: AppStrings.settingsRowOpenSourceLicenses,
                            trailingText: null,
                            onTap: () {
                              showLicensePage(
                                context: context,
                                applicationName: AppConfig.appName,
                                applicationVersion: versionText,
                              );
                            },
                          );
                        },
                      ),
                      Gaps.hSm,
                      _RowButton(
                        label: AppStrings.settingsRowPrivacy,
                        trailingText: null,
                        onTap: () => openPrivacy(context),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AppDangerButton(
                  label: AppStrings.settingsClearAllData,
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            AppStrings.settingsClearAllDataConfirmTitle,
                          ),
                          content: const Text(
                            AppStrings.settingsClearAllDataConfirmMessage,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(AppStrings.commonCancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(AppStrings.commonDelete),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm != true) return;
                    await context.read<SettingsProvider>().clearAllData();
                    if (!context.mounted) return;
                    await Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.splash,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.whiteOverlay70,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  const _RowButton({
    required this.label,
    required this.trailingText,
    required this.onTap,
  });

  final String label;
  final String? trailingText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lg,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteOverlay10,
          borderRadius: AppRadius.lg,
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.whiteOverlay70,
                ),
              ),
              Gaps.wSm,
            ],
            SvgPicture.asset(
              AppIcons.chevronRight,
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowSwitch extends StatelessWidget {
  const _RowSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.limeGreen,
            activeThumbColor: AppColors.limeGreen,
          ),
        ],
      ),
    );
  }
}

Future<int?> _pickDefaultTeamId(
  BuildContext context, {
  required List<Team> teams,
  required int? currentId,
}) async {
  final result = await showModalBottomSheet<int>(
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
                  AppStrings.settingsDefaultTeamNone,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () => Navigator.of(context).pop(0),
              ),
              const Divider(height: 1, color: AppColors.whiteOverlay20),
              for (final team in teams) ...[
                ListTile(
                  title: Text(
                    team.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: currentId == team.id
                      ? SvgPicture.asset(
                          AppIcons.check,
                          width: AppSizes.iconMd,
                          height: AppSizes.iconMd,
                          colorFilter: const ColorFilter.mode(
                            AppColors.limeGreen,
                            BlendMode.srcIn,
                          ),
                        )
                      : null,
                  onTap: () => Navigator.of(context).pop(team.id),
                ),
                if (team != teams.last)
                  const Divider(height: 1, color: AppColors.whiteOverlay20),
              ],
            ],
          ),
        ),
      );
    },
  );
  return result;
}

Future<int?> _pickDefaultFieldId(
  BuildContext context, {
  required List<Field> fields,
  required int? currentId,
}) async {
  final result = await showModalBottomSheet<int>(
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
                  AppStrings.settingsDefaultFieldNone,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () => Navigator.of(context).pop(0),
              ),
              const Divider(height: 1, color: AppColors.whiteOverlay20),
              for (final field in fields) ...[
                ListTile(
                  title: Text(
                    field.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: currentId == field.id
                      ? SvgPicture.asset(
                          AppIcons.check,
                          width: AppSizes.iconMd,
                          height: AppSizes.iconMd,
                          colorFilter: const ColorFilter.mode(
                            AppColors.limeGreen,
                            BlendMode.srcIn,
                          ),
                        )
                      : null,
                  onTap: () => Navigator.of(context).pop(field.id),
                ),
                if (field != fields.last)
                  const Divider(height: 1, color: AppColors.whiteOverlay20),
              ],
            ],
          ),
        ),
      );
    },
  );
  return result;
}
