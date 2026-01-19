import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../constants/app_limits.dart';
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

  final List<_DraftPlayer> _draftPlayers = [];

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
      _badgeId ??= AppImages.teamBadges.firstOrNull;
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
      _badgeId = team.badgeIcon ?? AppImages.teamBadges.firstOrNull;

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

    _badgeId ??= AppImages.teamBadges.firstOrNull;
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

    if (_badgeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.teamStudioBadgeRequiredError)),
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
      final settings = context.read<SettingsProvider>();
      if (settings.defaultTeamId == null) {
        await settings.setDefaultTeamId(id);
        await teamsProvider.setDefaultTeamFlag(id);
      }

      if (_draftPlayers.isNotEmpty) {
        for (final draft in List<_DraftPlayer>.from(_draftPlayers)) {
          await teamsProvider.createPlayer(
            teamId: id,
            name: draft.name,
            position: draft.position,
            number: draft.number,
          );
        }
        _draftPlayers.clear();
      }

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

  Future<void> _openPlayerDialog({
    Player? player,
    int? draftIndex,
  }) async {
    final teamId = _editingTeamId;
    final draft = draftIndex == null
        ? null
        : _draftPlayers.elementAtOrNull(draftIndex);

    await showDialog<void>(
      context: context,
      builder: (context) {
        return _PlayerDialog(
          initialName: player?.name ?? draft?.name ?? '',
          initialPosition: player?.position ?? draft?.position ?? 'GK',
          initialNumber: player?.number?.toString() ?? draft?.numberText ?? '',
          isEditing: player != null || draft != null,
          onSubmit: (name, position, number) async {
            if (teamId == null) {
              if (draftIndex == null) {
                setState(
                  () => _draftPlayers.add(
                    _DraftPlayer(
                      name: name,
                      position: position,
                      number: number,
                    ),
                  ),
                );
              } else {
                setState(
                  () => _draftPlayers[draftIndex] = _DraftPlayer(
                    name: name,
                    position: position,
                    number: number,
                  ),
                );
              }
              return;
            }

            final provider = context.read<TeamsProvider>();
            if (player == null) {
              await provider.createPlayer(
                teamId: teamId,
                name: name,
                position: position,
                number: number,
              );
              return;
            }

            await provider.updatePlayer(
              player.copyWith(
                name: name,
                position: Value(position),
                number: Value(number),
              ),
            );
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
      floatingActionButton: _tab == _Tab.roster
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
            bottom: false,
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
                              draftPlayers: _draftPlayers,
                              onEditDb: (p) => _openPlayerDialog(player: p),
                              onEditDraft: (index) =>
                                  _openPlayerDialog(draftIndex: index),
                              onDeleteDraft: (index) =>
                                  setState(() => _draftPlayers.removeAt(index)),
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(AppLimits.teamNameMax),
                ],
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
    required this.draftPlayers,
    required this.onEditDb,
    required this.onEditDraft,
    required this.onDeleteDraft,
  });

  final int? teamId;
  final List<_DraftPlayer> draftPlayers;
  final ValueChanged<Player> onEditDb;
  final ValueChanged<int> onEditDraft;
  final ValueChanged<int> onDeleteDraft;

  @override
  Widget build(BuildContext context) {
    if (teamId == null) {
      return _DraftRosterList(
        players: draftPlayers,
        onEdit: onEditDraft,
        onDelete: onDeleteDraft,
      );
    }

    return StreamBuilder<List<Player>>(
      stream: context.watch<TeamsProvider>().watchPlayersByTeam(teamId!),
      builder: (context, snapshot) {
        final players = snapshot.data ?? const [];
        return _DbRosterList(players: players, onEdit: onEditDb);
      },
    );
  }
}

class _DbRosterList extends StatelessWidget {
  const _DbRosterList({required this.players, required this.onEdit});

  final List<Player> players;
  final ValueChanged<Player> onEdit;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return Container(
        padding: Insets.allMd,
        decoration: BoxDecoration(
          color: AppColors.whiteOverlay10,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
        alignment: Alignment.center,
        child: Text(
          AppStrings.teamStudioRosterAddPlayersHint,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.whiteOverlay70,
          ),
        ),
      );
    }

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
  }
}

class _DraftRosterList extends StatelessWidget {
  const _DraftRosterList({
    required this.players,
    required this.onEdit,
    required this.onDelete,
  });

  final List<_DraftPlayer> players;
  final ValueChanged<int> onEdit;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return Container(
        padding: Insets.allMd,
        decoration: BoxDecoration(
          color: AppColors.whiteOverlay10,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
        alignment: Alignment.center,
        child: Text(
          AppStrings.teamStudioRosterAddPlayersHint,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.whiteOverlay70,
          ),
        ),
      );
    }

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
            _DraftPlayerRow(
              player: players[i],
              onEdit: () => onEdit(i),
              onDelete: () => onDelete(i),
            ),
            if (i != players.length - 1)
              const Divider(height: 18, color: AppColors.whiteOverlay20),
          ],
        ],
      ),
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
  const _PlayerDialog({
    required this.initialName,
    required this.initialPosition,
    required this.initialNumber,
    required this.isEditing,
    required this.onSubmit,
  });

  final String initialName;
  final String initialPosition;
  final String initialNumber;
  final bool isEditing;
  final Future<void> Function(String name, String position, int number)
  onSubmit;

  @override
  State<_PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<_PlayerDialog> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  String _position = 'GK';

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _numberController.text = widget.initialNumber;
    _position = widget.initialPosition;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.teamStudioPlayerNameRequired)),
      );
      return;
    }

    final numberText = _numberController.text.trim();
    final number = int.tryParse(numberText);
    if (number == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.teamStudioPlayerNumberRequired),
        ),
      );
      return;
    }

    setState(() => _saving = true);
    await widget.onSubmit(name, _position, number);
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
              widget.isEditing
                  ? AppStrings.commonSave
                  : AppStrings.teamStudioPlayerDialogTitle,
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppLimits.playerNameMax),
              ],
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
                      _PositionDropdown(
                        value: _position,
                        onChanged: (value) => setState(() => _position = value),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            AppLimits.playerNumberMaxDigits,
                          ),
                        ],
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
                    label: widget.isEditing
                        ? AppStrings.commonSave
                        : AppStrings.commonAdd,
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

class _PositionDropdown extends StatelessWidget {
  const _PositionDropdown({required this.value, required this.onChanged});

  static const List<String> _positions = ['GK', 'DF', 'MF', 'FW'];

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
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
        contentPadding: Insets.hMd,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _positions.contains(value) ? value : _positions.first,
          dropdownColor: AppColors.darkNavy,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
          items: _positions
              .map(
                (p) => DropdownMenuItem<String>(
                  value: p,
                  child: Text(
                    p,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: (next) {
            if (next == null) return;
            onChanged(next);
          },
        ),
      ),
    );
  }
}

class _DraftPlayerRow extends StatelessWidget {
  const _DraftPlayerRow({
    required this.player,
    required this.onEdit,
    required this.onDelete,
  });

  final _DraftPlayer player;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[
      '${AppStrings.teamStudioPlayerPositionLabel}: ${player.position}',
      '${AppStrings.teamStudioPlayerNumberLabel}: ${player.number}',
    ];

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.hXs,
              Text(
                subtitleParts.join(' • '),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.whiteOverlay70,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
          onPressed: onEdit,
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
          onPressed: onDelete,
        ),
      ],
    );
  }
}

class _DraftPlayer {
  const _DraftPlayer({
    required this.name,
    required this.position,
    required this.number,
  });

  final String name;
  final String position;
  final int number;

  String get numberText => number.toString();
}

extension on Iterable<Team> {
  Team? get firstOrNull => isEmpty ? null : first;
}

extension<T> on List<T> {
  T? elementAtOrNull(int index) =>
      index < 0 || index >= length ? null : this[index];
}

class TeamStudioArgs {
  const TeamStudioArgs({this.teamId, this.createNew = false});

  final int? teamId;
  final bool createNew;
}
