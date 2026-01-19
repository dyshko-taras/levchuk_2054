import 'package:drift/drift.dart' show Value;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import 'lineup_tactics_board_page.dart';
import 'match_composer_page.dart';

class MatchCenterPage extends StatefulWidget {
  const MatchCenterPage({super.key});

  @override
  State<MatchCenterPage> createState() => _MatchCenterPageState();
}

class _MatchCenterPageState extends State<MatchCenterPage> {
  bool _finalizing = false;

  String? _result; // team_a | team_b | draw
  final TextEditingController _scoreAController = TextEditingController();
  final TextEditingController _scoreBController = TextEditingController();

  bool _savingFinalize = false;

  @override
  void dispose() {
    _scoreAController.dispose();
    _scoreBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final matchId = args is MatchCenterArgs ? args.matchId : null;
    final match = matchId == null
        ? null
        : context
              .watch<MatchesProvider>()
              .matches
              .where((m) => m.id == matchId)
              .firstOrNull;

    if (match == null) {
      return const Scaffold(
        body: ColoredBox(
          color: AppColors.darkNavy,
          child: SafeArea(child: SizedBox.shrink()),
        ),
      );
    }

    final teams = context.watch<TeamsProvider>().teams;
    final fields = context.watch<FieldsProvider>().fields;

    final teamA = match.teamAId == null
        ? null
        : teams.where((t) => t.id == match.teamAId).firstOrNull;
    final teamB = match.teamBId == null
        ? null
        : teams.where((t) => t.id == match.teamBId).firstOrNull;
    final field = match.fieldId == null
        ? null
        : fields.where((f) => f.id == match.fieldId).firstOrNull;

    final infoRow = _buildInfoRow(
      context,
      match: match,
      fieldName: field?.name,
    );

    final headerTitle = _buildHeaderTitle(
      teamAName: teamA?.name ?? AppStrings.matchCenterTeamATbd,
      teamBName: teamB?.name,
    );

    final isFinished = match.status == 'finished';

    final showFinalize = _finalizing || (isFinished && match.result != null);

    if (showFinalize &&
        _result == null &&
        (match.result != null || _finalizing)) {
      _result ??= match.result;
      if (_scoreAController.text.isEmpty) {
        _scoreAController.text = match.scoreA?.toString() ?? '';
      }
      if (_scoreBController.text.isEmpty) {
        _scoreBController.text = match.scoreB?.toString() ?? '';
      }
    }

    final backgroundPath = field?.photoPath ?? AppImages.fieldPhotoPlaceholder;

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
                      label: AppStrings.matchCenterTitle,
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
                _MatchSummaryCard(
                  title: headerTitle,
                  infoRow: infoRow,
                  backgroundPath: backgroundPath,
                ),
                Gaps.hMd,
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Text(
                        AppStrings.matchCenterRostersPreviewA,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteOverlay70,
                        ),
                      ),
                      Gaps.hSm,
                      _RosterCard(
                        badgeAsset: teamA?.badgeIcon,
                        title: teamA?.name ?? AppStrings.matchCenterTeamATbd,
                        infoRow: infoRow,
                      ),
                      Gaps.hSm,
                      _ActionsBar(
                        canJoinTeamB: match.teamBId == null,
                        canOpenLineup: !isFinished,
                        onEditMatch: () => Navigator.of(context).pushNamed(
                          AppRoutes.matchComposer,
                          arguments: MatchComposerArgs(matchId: match.id),
                        ),
                        onJoinTeamB: match.teamBId == null
                            ? () async {
                                final selectedId = await _pickTeam(
                                  context,
                                  teams: teams,
                                );
                                if (selectedId == null) return;
                                await context
                                    .read<MatchesProvider>()
                                    .updateMatch(
                                      match.copyWith(
                                        teamBId: Value(selectedId),
                                        updatedAt: Value(DateTime.now()),
                                      ),
                                    );
                              }
                            : null,
                        onMarkFinished: isFinished
                            ? null
                            : () => setState(() => _finalizing = true),
                        onOpenLineup: !isFinished
                            ? () => Navigator.of(context).pushNamed(
                                AppRoutes.lineupTactics,
                                arguments: LineupTacticsArgs(matchId: match.id),
                              )
                            : null,
                      ),
                      Gaps.hMd,
                      Text(
                        AppStrings.matchCenterRostersPreviewB,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteOverlay70,
                        ),
                      ),
                      Gaps.hSm,
                      _RosterCard(
                        badgeAsset: teamB?.badgeIcon,
                        title: teamB?.name ?? AppStrings.matchCenterTeamBTbd,
                        infoRow: infoRow,
                      ),
                      Gaps.hSm,
                      _ActionsBar(
                        canJoinTeamB: match.teamBId == null,
                        canOpenLineup: !isFinished,
                        onEditMatch: () => Navigator.of(context).pushNamed(
                          AppRoutes.matchComposer,
                          arguments: MatchComposerArgs(matchId: match.id),
                        ),
                        onJoinTeamB: match.teamBId == null
                            ? () async {
                                final selectedId = await _pickTeam(
                                  context,
                                  teams: teams,
                                );
                                if (selectedId == null) return;
                                await context
                                    .read<MatchesProvider>()
                                    .updateMatch(
                                      match.copyWith(
                                        teamBId: Value(selectedId),
                                        updatedAt: Value(DateTime.now()),
                                      ),
                                    );
                              }
                            : null,
                        onMarkFinished: isFinished
                            ? null
                            : () => setState(() => _finalizing = true),
                        onOpenLineup: !isFinished
                            ? () => Navigator.of(context).pushNamed(
                                AppRoutes.lineupTactics,
                                arguments: LineupTacticsArgs(matchId: match.id),
                              )
                            : null,
                      ),
                      if (showFinalize) ...[
                        Gaps.hMd,
                        Text(
                          AppStrings.matchCenterFinalizeTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Gaps.hSm,
                        _FinalizeCard(
                          teamAName:
                              teamA?.name ?? AppStrings.matchCenterTeamATbd,
                          teamBName:
                              teamB?.name ?? AppStrings.matchCenterTeamBTbd,
                          selectedResult: _result,
                          onSelectResult: (value) =>
                              setState(() => _result = value),
                          scoreAController: _scoreAController,
                          scoreBController: _scoreBController,
                        ),
                      ],
                    ],
                  ),
                ),
                if (showFinalize) ...[
                  Gaps.hMd,
                  AppPrimaryButton(
                    label: AppStrings.matchCenterFinalizeSave,
                    onPressed: _savingFinalize
                        ? () {}
                        : () => _saveFinalize(context, match),
                  ),
                  Gaps.hSm,
                  AppDangerButton(
                    label: AppStrings.matchCenterFinalizeCancel,
                    onPressed: () => setState(() {
                      _finalizing = false;
                      _result = null;
                      _scoreAController.clear();
                      _scoreBController.clear();
                    }),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveFinalize(BuildContext context, Fixture match) async {
    if (_savingFinalize) return;

    final result = _result;
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchCenterFinalizeWinRequired),
        ),
      );
      return;
    }

    final scoreA = int.tryParse(_scoreAController.text.trim());
    final scoreB = int.tryParse(_scoreBController.text.trim());

    setState(() => _savingFinalize = true);
    await context.read<MatchesProvider>().updateMatch(
      match.copyWith(
        status: 'finished',
        result: Value(result),
        scoreA: Value(scoreA),
        scoreB: Value(scoreB),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (!mounted) return;
    setState(() {
      _savingFinalize = false;
      _finalizing = false;
    });
  }
}

class _MatchSummaryCard extends StatelessWidget {
  const _MatchSummaryCard({
    required this.title,
    required this.infoRow,
    required this.backgroundPath,
  });

  final String title;
  final String infoRow;
  final String backgroundPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.xl,
      child: Stack(
        children: [
          Positioned.fill(
            child: _AnyImage(path: backgroundPath),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkNavy.withValues(alpha: 0.15),
                    AppColors.darkNavy.withValues(alpha: 0.70),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: Insets.allMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.hXs,
                Text(
                  infoRow,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnyImage extends StatelessWidget {
  const _AnyImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const ColoredBox(color: AppColors.whiteOverlay10),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const ColoredBox(color: AppColors.whiteOverlay10),
    );
  }
}

class _RosterCard extends StatelessWidget {
  const _RosterCard({
    required this.badgeAsset,
    required this.title,
    required this.infoRow,
  });

  final String? badgeAsset;
  final String title;
  final String infoRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.matchCenterBadgeSize,
            height: AppSizes.matchCenterBadgeSize,
            child: badgeAsset == null
                ? const DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.whiteOverlay10,
                      shape: BoxShape.circle,
                    ),
                  )
                : ClipOval(
                    child: Image.asset(
                      badgeAsset!,
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
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Gaps.hXs,
                Text(
                  infoRow,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionsBar extends StatelessWidget {
  const _ActionsBar({
    required this.canJoinTeamB,
    required this.canOpenLineup,
    required this.onEditMatch,
    required this.onJoinTeamB,
    required this.onMarkFinished,
    required this.onOpenLineup,
  });

  final bool canJoinTeamB;
  final bool canOpenLineup;
  final VoidCallback onEditMatch;
  final VoidCallback? onJoinTeamB;
  final VoidCallback? onMarkFinished;
  final VoidCallback? onOpenLineup;

  @override
  Widget build(BuildContext context) {
    final items = [
      _ActionItem(
        label: AppStrings.matchCenterActionEditMatch,
        onPressed: onEditMatch,
        isPrimary: true,
      ),
      _ActionItem(
        label: AppStrings.matchCenterActionJoinTeamB,
        onPressed: canJoinTeamB ? onJoinTeamB : null,
      ),
      _ActionItem(
        label: AppStrings.matchCenterActionMarkFinished,
        onPressed: onMarkFinished,
      ),
      _ActionItem(
        label: AppStrings.matchCenterActionOpenLineup,
        onPressed: canOpenLineup ? onOpenLineup : null,
      ),
    ];

    return Container(
      height: AppSizes.hubQuickBarHeight,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: ClipRRect(
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
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: item.isPrimary
                          ? AppColors.primaryBlue
                          : AppColors.whiteOverlay20,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: item.onPressed,
                    child: Text(
                      item.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (item != items.last) Gaps.wSm,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionItem {
  const _ActionItem({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
}

class _FinalizeCard extends StatelessWidget {
  const _FinalizeCard({
    required this.teamAName,
    required this.teamBName,
    required this.selectedResult,
    required this.onSelectResult,
    required this.scoreAController,
    required this.scoreBController,
  });

  final String teamAName;
  final String teamBName;
  final String? selectedResult;
  final ValueChanged<String> onSelectResult;
  final TextEditingController scoreAController;
  final TextEditingController scoreBController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.matchCenterFinalizeWinLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gaps.hSm,
          Row(
            children: [
              Expanded(
                child: _ResultOption(
                  label: teamBName,
                  value: 'team_b',
                  groupValue: selectedResult,
                  onSelect: onSelectResult,
                ),
              ),
              Expanded(
                child: _ResultOption(
                  label: teamAName,
                  value: 'team_a',
                  groupValue: selectedResult,
                  onSelect: onSelectResult,
                ),
              ),
              Expanded(
                child: _ResultOption(
                  label: AppStrings.matchCenterFinalizeDraw,
                  value: 'draw',
                  groupValue: selectedResult,
                  onSelect: onSelectResult,
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.whiteOverlay20),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ScoreField(controller: scoreAController),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Text(
                    '–',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _ScoreField(controller: scoreBController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultOption extends StatelessWidget {
  const _ResultOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onSelect,
  });

  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final selected = groupValue == value;
    return InkWell(
      onTap: () => onSelect(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppSizes.matchCenterResultIndicatorSize,
            height: AppSizes.matchCenterResultIndicatorSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.white : AppColors.whiteOverlay70,
              ),
            ),
            child: selected
                ? const Center(
                    child: Icon(
                      Icons.check,
                      size: AppSizes.matchCenterResultIndicatorCheckSize,
                      color: AppColors.white,
                    ),
                  )
                : null,
          ),
          Gaps.wSm,
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreField extends StatelessWidget {
  const _ScoreField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.matchCenterScoreFieldWidth,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: AppSizes.matchCenterScoreFontSize,
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

String _buildHeaderTitle({
  required String teamAName,
  required String? teamBName,
}) {
  if (teamBName == null || teamBName.trim().isEmpty) {
    return '$teamAName vs ${AppStrings.matchCenterTeamBTbd}';
  }
  return '$teamAName vs $teamBName';
}

String _buildInfoRow(
  BuildContext context, {
  required Fixture match,
  required String? fieldName,
}) {
  final date = MaterialLocalizations.of(
    context,
  ).formatMediumDate(match.startAt);
  final time = MaterialLocalizations.of(context).formatTimeOfDay(
    TimeOfDay.fromDateTime(match.startAt),
    alwaysUse24HourFormat: true,
  );
  final field = fieldName ?? AppStrings.commonPlaceholderDash;
  final status = match.status == 'finished'
      ? AppStrings.availabilityStatusFinished
      : AppStrings.availabilityMatchPlanned;
  return '${AppStrings.availabilityMatchCardTime(date, time)} • $field • $status';
}

Future<int?> _pickTeam(
  BuildContext context, {
  required List<Team> teams,
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
              for (final team in teams) ...[
                ListTile(
                  title: Text(
                    team.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class MatchCenterArgs {
  const MatchCenterArgs({required this.matchId});

  final int matchId;
}
