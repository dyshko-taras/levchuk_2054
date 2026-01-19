import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/models/team_directory_item.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import 'team_studio_page.dart';

class TeamsDirectoryPage extends StatelessWidget {
  const TeamsDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const ColoredBox(
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
    return Padding(
      padding: Insets.allMd,
      child: Column(
        children: [
          Row(
            children: [
              AppTopBarTextButton(
                label: AppStrings.teamsDirectoryTitle,
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
                  AppRoutes.teamStudio,
                  arguments: const TeamStudioArgs(createNew: true),
                ),
              ),
            ],
          ),
          Gaps.hMd,
          Expanded(
            child: StreamBuilder<List<TeamDirectoryItem>>(
              stream: context.watch<TeamsProvider>().watchTeamsDirectory(),
              builder: (context, snapshot) {
                final items = snapshot.data ?? const [];
                if (items.isEmpty) {
                  return _EmptyState(
                    onCreate: () => Navigator.of(context).pushNamed(
                      AppRoutes.teamStudio,
                      arguments: const TeamStudioArgs(createNew: true),
                    ),
                  );
                }

                return _TeamsList(items: items);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamsList extends StatelessWidget {
  const _TeamsList({required this.items});

  final List<TeamDirectoryItem> items;

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
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: AppColors.whiteOverlay20),
        itemBuilder: (context, index) {
          final item = items[index];
          final badgeAsset = item.team.badgeIcon;
          final playersCountText =
              '${AppStrings.teamsDirectoryPlayersCountPrefix} ${item.playersCount}';

          return Row(
            children: [
              SizedBox(
                width: AppSizes.iconButtonSize,
                height: AppSizes.iconButtonSize,
                child: badgeAsset == null
                    ? const DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.whiteOverlay10,
                          shape: BoxShape.circle,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          badgeAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.whiteOverlay10,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
              ),
              Gaps.wSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.team.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.hXs,
                    Text(
                      playersCountText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteOverlay70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.teamsDirectoryRowButtonHeight,
                child: AppPillButton(
                  label: AppStrings.hubActionOpen,
                  onPressed: () => Navigator.of(context).pushNamed(
                    AppRoutes.teamStudio,
                    arguments: TeamStudioArgs(teamId: item.team.id),
                  ),
                  backgroundColor: AppColors.whiteOverlay10,
                ),
              ),
              Gaps.wSm,
              AppIconCircleButton(
                icon: SvgPicture.asset(
                  AppIcons.more,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () async {
                  final canDelete = await context
                      .read<TeamsProvider>()
                      .canDeleteTeam(item.team.id);
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
                                  AppStrings.teamStudioMenuDeleteTeam,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: canDelete
                                            ? AppColors.darkRed
                                            : AppColors.whiteOverlay70,
                                      ),
                                ),
                                onTap: canDelete
                                    ? () async {
                                        Navigator.of(context).pop();
                                        await context
                                            .read<TeamsProvider>()
                                            .deleteTeamById(item.team.id);
                                        final settings = context
                                            .read<SettingsProvider>();
                                        if (settings.defaultTeamId ==
                                            item.team.id) {
                                          await settings.setDefaultTeamId(null);
                                        }
                                      }
                                    : () {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              AppStrings
                                                  .teamStudioDeleteNotAllowed,
                                            ),
                                          ),
                                        );
                                      },
                              ),
                              const Divider(
                                height: 1,
                                color: AppColors.whiteOverlay20,
                              ),
                              ListTile(
                                title: Text(
                                  AppStrings.teamStudioMenuSetAsDefault,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  await context
                                      .read<SettingsProvider>()
                                      .setDefaultTeamId(item.team.id);
                                  await context
                                      .read<TeamsProvider>()
                                      .setDefaultTeamFlag(item.team.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
            AppStrings.teamsDirectoryEmpty,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gaps.hMd,
          SizedBox(
            width: AppSizes.teamsDirectoryEmptyButtonWidth,
            child: AppPrimaryButton(
              label: AppStrings.teamsDirectoryNewTeam,
              onPressed: onCreate,
            ),
          ),
        ],
      ),
    );
  }
}
