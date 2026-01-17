import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_fields.dart';
import '../widgets/navigation/quick_bar.dart';
import '../widgets/team_studio/badge_picker.dart';
import '../widgets/team_studio/kit_preview.dart';
import '../widgets/team_studio/preset_color_row.dart';

class TeamStudioPage extends StatefulWidget {
  const TeamStudioPage({super.key});

  @override
  State<TeamStudioPage> createState() => _TeamStudioPageState();
}

class _TeamStudioPageState extends State<TeamStudioPage> {
  _Tab _tab = _Tab.profile;

  final TextEditingController _nameController = TextEditingController();
  String? _badgeId;

  Color _homePrimary = const Color(0xFFFF0000);
  Color _homeSecondary = const Color(0xFF0000FF);
  Color _awayPrimary = const Color(0xFF2196F3);
  Color _awaySecondary = const Color(0xFFFFFFFF);

  int? _editingTeamId;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initFromState());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _initFromState() {
    final teams = context.read<TeamsProvider>().teams;
    final settings = context.read<SettingsProvider>();
    final defaultId = settings.defaultTeamId;

    final args = ModalRoute.of(context)?.settings.arguments;
    final requestedTeamId = args is TeamStudioArgs ? args.teamId : null;
    final createNew = args is TeamStudioArgs ? args.createNew : false;

    if (createNew) {
      setState(() => _loading = false);
      return;
    }

    final Team? team = requestedTeamId != null
        ? teams.where((t) => t.id == requestedTeamId).firstOrNull
        : defaultId == null
        ? (teams.isEmpty ? null : teams.first)
        : teams.where((t) => t.id == defaultId).firstOrNull;

    if (team != null) {
      _editingTeamId = team.id;
      _nameController.text = team.name;
      _badgeId = team.badgeIcon;

      _homePrimary = team.homePrimaryColor == null
          ? _homePrimary
          : Color(team.homePrimaryColor!);
      _homeSecondary = team.homeSecondaryColor == null
          ? _homeSecondary
          : Color(team.homeSecondaryColor!);
      _awayPrimary = team.awayPrimaryColor == null
          ? _awayPrimary
          : Color(team.awayPrimaryColor!);
      _awaySecondary = team.awaySecondaryColor == null
          ? _awaySecondary
          : Color(team.awaySecondaryColor!);
    }

    setState(() => _loading = false);
  }

  Future<void> _save() async {
    if (_saving) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.teamStudioNameRequiredError)),
      );
      return;
    }

    final teamsProvider = context.read<TeamsProvider>();
    final unique = await teamsProvider.isTeamNameUnique(
      name,
      excludeTeamId: _editingTeamId,
    );
    if (!unique) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.teamStudioNameNotUniqueError)),
      );
      return;
    }

    setState(() => _saving = true);
    if (_editingTeamId == null) {
      final id = await teamsProvider.createTeam(
        name: name,
        badgeIcon: _badgeId,
        homePrimaryColor: _homePrimary.toARGB32(),
        homeSecondaryColor: _homeSecondary.toARGB32(),
        awayPrimaryColor: _awayPrimary.toARGB32(),
        awaySecondaryColor: _awaySecondary.toARGB32(),
      );
      await context.read<SettingsProvider>().setDefaultTeamId(id);
      await teamsProvider.setDefaultTeamFlag(id);
      _editingTeamId = id;
    } else {
      final Team? current = teamsProvider.teams
          .where((t) => t.id == _editingTeamId)
          .firstOrNull;
      if (current != null) {
        await teamsProvider.updateTeam(
          current.copyWith(
            name: name,
            badgeIcon: Value(_badgeId),
            homePrimaryColor: Value(_homePrimary.toARGB32()),
            homeSecondaryColor: Value(_homeSecondary.toARGB32()),
            awayPrimaryColor: Value(_awayPrimary.toARGB32()),
            awaySecondaryColor: Value(_awaySecondary.toARGB32()),
          ),
        );
      }
    }

    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.of(context).pop();
  }

  Future<void> _openMoreMenu() async {
    final teamId = _editingTeamId;
    if (teamId == null) return;

    final canDelete = await context.read<TeamsProvider>().canDeleteTeam(teamId);

    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: canDelete
                          ? AppColors.darkRed
                          : AppColors.whiteOverlay70,
                    ),
                  ),
                  onTap: canDelete
                      ? () async {
                          Navigator.of(context).pop();
                          await context.read<TeamsProvider>().deleteTeamById(
                            teamId,
                          );
                          await context
                              .read<SettingsProvider>()
                              .setDefaultTeamId(null);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        }
                      : () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                AppStrings.teamStudioDeleteNotAllowed,
                              ),
                            ),
                          );
                        },
                ),
                const Divider(height: 1, color: AppColors.whiteOverlay20),
                ListTile(
                  title: Text(
                    AppStrings.teamStudioMenuSetAsDefault,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await context.read<SettingsProvider>().setDefaultTeamId(
                      teamId,
                    );
                    await context.read<TeamsProvider>().setDefaultTeamFlag(
                      teamId,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openPlayerDialog({Player? player}) async {
    final teamId = _editingTeamId;
    if (teamId == null) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return _PlayerDialog(
          player: player,
          onSubmit: (name, position, number) async {
            final provider = context.read<TeamsProvider>();
            if (player == null) {
              await provider.createPlayer(
                teamId: teamId,
                name: name,
                position: position,
                number: number,
              );
            } else {
              await provider.updatePlayer(
                player.copyWith(
                  name: name,
                  position: Value(position),
                  number: Value(number),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final teamId = _editingTeamId;

    return Scaffold(
      floatingActionButton: _tab == _Tab.roster && teamId != null
          ? SizedBox(
              height: AppSizes.hubFabSize,
              width: AppSizes.hubFabSize,
              child: FloatingActionButton(
                backgroundColor: AppColors.limeGreen,
                onPressed: () => _openPlayerDialog(),
                child: SvgPicture.asset(
                  AppIcons.add,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.darkNavy),
          SafeArea(
            child: Padding(
              padding: Insets.allMd,
              child: Column(
                children: [
                  Row(
                    children: [
                      AppTopBarTextButton(
                        label: AppStrings.teamStudioTitle,
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
                          AppIcons.more,
                          width: AppSizes.iconMd,
                          height: AppSizes.iconMd,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: _openMoreMenu,
                      ),
                    ],
                  ),
                  Gaps.hMd,
                  QuickBar(
                    items: [
                      QuickBarItem(
                        label: AppStrings.teamStudioTabProfile,
                        isSelected: _tab == _Tab.profile,
                        onPressed: () => setState(() => _tab = _Tab.profile),
                      ),
                      QuickBarItem(
                        label: AppStrings.teamStudioTabRoster,
                        isSelected: _tab == _Tab.roster,
                        onPressed: () => setState(() => _tab = _Tab.roster),
                      ),
                    ],
                  ),
                  Gaps.hMd,
                  Expanded(
                    child: SingleChildScrollView(
                      child: _tab == _Tab.profile
                          ? _ProfileTab(
                              nameController: _nameController,
                              badgeAsset: _badgeId,
                              onBadgeSelect: (asset) =>
                                  setState(() => _badgeId = asset),
                              homePrimary: _homePrimary,
                              homeSecondary: _homeSecondary,
                              onHomePrimary: (c) =>
                                  setState(() => _homePrimary = c),
                              onHomeSecondary: (c) =>
                                  setState(() => _homeSecondary = c),
                              awayPrimary: _awayPrimary,
                              awaySecondary: _awaySecondary,
                              onAwayPrimary: (c) =>
                                  setState(() => _awayPrimary = c),
                              onAwaySecondary: (c) =>
                                  setState(() => _awaySecondary = c),
                              saving: _saving,
                              onSave: _save,
                            )
                          : _RosterTab(
                              teamId: teamId,
                              onEdit: (p) => _openPlayerDialog(player: p),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _Tab { profile, roster }

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({
    required this.nameController,
    required this.badgeAsset,
    required this.onBadgeSelect,
    required this.homePrimary,
    required this.homeSecondary,
    required this.onHomePrimary,
    required this.onHomeSecondary,
    required this.awayPrimary,
    required this.awaySecondary,
    required this.onAwayPrimary,
    required this.onAwaySecondary,
    required this.saving,
    required this.onSave,
  });

  final TextEditingController nameController;
  final String? badgeAsset;
  final ValueChanged<String> onBadgeSelect;

  final Color homePrimary;
  final Color homeSecondary;
  final ValueChanged<Color> onHomePrimary;
  final ValueChanged<Color> onHomeSecondary;

  final Color awayPrimary;
  final Color awaySecondary;
  final ValueChanged<Color> onAwayPrimary;
  final ValueChanged<Color> onAwaySecondary;

  final bool saving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: Insets.allMd,
          decoration: BoxDecoration(
            color: AppColors.whiteOverlay10,
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            border: Border.all(color: AppColors.whiteOverlay20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: const [
                    TextSpan(text: AppStrings.teamStudioTeamNameLabel),
                    TextSpan(
                      text: ' ${AppStrings.teamStudioTeamNameRequiredMarker}',
                      style: TextStyle(color: AppColors.darkRed),
                    ),
                  ],
                ),
              ),
              Gaps.hSm,
              AppPillTextField(
                controller: nameController,
                hintText: AppStrings.teamStudioTeamNameHint,
              ),
              Gaps.hLg,
              Text(
                AppStrings.teamStudioBadgeIconLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.hSm,
              SizedBox(
                height: 120,
                child: BadgePicker(
                  selectedAsset: badgeAsset,
                  onSelect: onBadgeSelect,
                ),
              ),
              Gaps.hLg,
              Text(
                AppStrings.teamStudioHomeColorsLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.hSm,
              Row(
                children: [
                  KitPreview(primary: homePrimary, secondary: homeSecondary),
                  const Spacer(),
                  PresetColorRow(
                    primary: homePrimary,
                    secondary: homeSecondary,
                    onPrimaryChanged: onHomePrimary,
                    onSecondaryChanged: onHomeSecondary,
                  ),
                ],
              ),
              Gaps.hLg,
              Text(
                AppStrings.teamStudioAwayColorsLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.hSm,
              Row(
                children: [
                  KitPreview(primary: awayPrimary, secondary: awaySecondary),
                  const Spacer(),
                  PresetColorRow(
                    primary: awayPrimary,
                    secondary: awaySecondary,
                    onPrimaryChanged: onAwayPrimary,
                    onSecondaryChanged: onAwaySecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        Gaps.hMd,
        AppPrimaryButton(
          label: AppStrings.teamStudioSave,
          onPressed: saving ? () {} : onSave,
        ),
      ],
    );
  }
}

class _RosterTab extends StatelessWidget {
  const _RosterTab({
    required this.teamId,
    required this.onEdit,
  });

  final int? teamId;
  final ValueChanged<Player> onEdit;

  @override
  Widget build(BuildContext context) {
    if (teamId == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<List<Player>>(
      stream: context.watch<TeamsProvider>().watchPlayersByTeam(teamId!),
      builder: (context, snapshot) {
        final players = snapshot.data ?? const [];
        return Container(
          padding: Insets.allMd,
          decoration: BoxDecoration(
            color: AppColors.whiteOverlay10,
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            border: Border.all(color: AppColors.whiteOverlay20),
          ),
          child: Column(
            children: [
              for (var i = 0; i < players.length; i++) ...[
                _PlayerRow(player: players[i], onEdit: onEdit),
                if (i != players.length - 1)
                  const Divider(height: 18, color: AppColors.whiteOverlay20),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({required this.player, required this.onEdit});

  final Player player;
  final ValueChanged<Player> onEdit;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[];
    if (player.position != null && player.position!.isNotEmpty) {
      subtitleParts.add(
        '${AppStrings.teamStudioPlayerPositionLabel}: ${player.position}',
      );
    }
    if (player.number != null) {
      subtitleParts.add(
        '${AppStrings.teamStudioPlayerNumberLabel}: ${player.number}',
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(player.name, style: Theme.of(context).textTheme.titleMedium),
              if (subtitleParts.isNotEmpty) ...[
                Gaps.hXs,
                Text(
                  subtitleParts.join(' • '),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
              ],
            ],
          ),
        ),
        AppIconCircleButton(
          icon: SvgPicture.asset(
            AppIcons.edit,
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => onEdit(player),
        ),
        Gaps.wSm,
        AppIconCircleButton(
          icon: SvgPicture.asset(
            AppIcons.delete,
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () =>
              context.read<TeamsProvider>().deletePlayerById(player.id),
        ),
      ],
    );
  }
}

class _PlayerDialog extends StatefulWidget {
  const _PlayerDialog({required this.player, required this.onSubmit});

  final Player? player;
  final Future<void> Function(String name, String? position, int? number)
  onSubmit;

  @override
  State<_PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<_PlayerDialog> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _numberController = TextEditingController();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.player;
    if (p != null) {
      _nameController.text = p.name;
      _positionController.text = p.position ?? '';
      _numberController.text = p.number?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final pos = _positionController.text.trim();
    final number = int.tryParse(_numberController.text.trim());

    setState(() => _saving = true);
    await widget.onSubmit(name, pos.isEmpty ? null : pos, number);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteOverlay10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        side: const BorderSide(color: AppColors.whiteOverlay20),
      ),
      child: Padding(
        padding: Insets.allMd,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.player == null
                  ? AppStrings.teamStudioPlayerDialogTitle
                  : AppStrings.commonSave,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.hMd,
            Text(
              AppStrings.teamStudioPlayerNameLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gaps.hXs,
            AppPillTextField(
              controller: _nameController,
              hintText: AppStrings.teamStudioPlayerNameHint,
              suffixIconAsset: null,
            ),
            Gaps.hSm,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.teamStudioPlayerPositionLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gaps.hXs,
                      AppPillTextField(
                        controller: _positionController,
                        hintText: null,
                        suffixIconAsset: null,
                      ),
                    ],
                  ),
                ),
                Gaps.wSm,
                SizedBox(
                  width: AppSizes.teamStudioPlayerNumberFieldWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.teamStudioPlayerNumberLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gaps.hXs,
                      AppPillTextField(
                        controller: _numberController,
                        hintText: null,
                        suffixIconAsset: null,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
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
                    label: widget.player == null
                        ? AppStrings.commonAdd
                        : AppStrings.commonSave,
                    onPressed: _saving ? () {} : _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on Iterable<Team> {
  Team? get firstOrNull => isEmpty ? null : first;
}

class TeamStudioArgs {
  const TeamStudioArgs({this.teamId, this.createNew = false});

  final int? teamId;
  final bool createNew;
}
