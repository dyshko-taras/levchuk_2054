import 'package:drift/drift.dart' show Value;
import 'package:field_captain/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/lineup_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/tactics_provider.dart';
import '../../providers/teams_provider.dart';
import '../../utils/date_time_format.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_fields.dart';
import '../widgets/navigation/quick_bar.dart';

class LineupTacticsBoardPage extends StatefulWidget {
  const LineupTacticsBoardPage({super.key});

  @override
  State<LineupTacticsBoardPage> createState() => _LineupTacticsBoardPageState();
}

class _LineupTacticsBoardPageState extends State<LineupTacticsBoardPage> {
  _Tab _tab = _Tab.lineup;
  _TeamSide _teamSide = _TeamSide.a;
  int? _activeSlotIndex;

  bool _dirty = false;
  bool _saving = false;
  bool _suppressDirty = false;

  final TextEditingController _searchController = TextEditingController();

  String? _pressing;
  String? _width;
  String? _buildUp;

  final TextEditingController _cornersController = TextEditingController();
  final TextEditingController _freeKicksController = TextEditingController();
  final TextEditingController _keyMatchupsController = TextEditingController();

  final List<_DoDontDraft> _doDontDrafts = [];

  final TextEditingController _pitchFeeController = TextEditingController();
  _FeeSplitMode _feeSplitMode = _FeeSplitMode.confirmedOnly;
  DateTime? _meetTime;
  bool _bringCash = false;
  bool _bringBibs = false;
  bool _bringBall = false;
  bool _bringWater = false;
  final TextEditingController _crewNotesController = TextEditingController();

  final Map<int, Map<int, bool>> _attendanceByTeamId = {};
  final Map<int, _TeamDraft> _teamDrafts = {};

  bool _tacticsInitialized = false;
  bool _matchLogisticsInitialized = false;

  @override
  void initState() {
    super.initState();
    _cornersController.addListener(_onDataChanged);
    _freeKicksController.addListener(_onDataChanged);
    _keyMatchupsController.addListener(_onDataChanged);
    _pitchFeeController.addListener(_onDataChanged);
    _crewNotesController.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cornersController.dispose();
    _freeKicksController.dispose();
    _keyMatchupsController.dispose();
    _pitchFeeController.dispose();
    _crewNotesController.dispose();
    super.dispose();
  }

  void _onDataChanged() {
    if (_suppressDirty) return;
    if (_dirty) return;
    if (!mounted) return;
    setState(() => _dirty = true);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! LineupTacticsArgs) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final matches = context.watch<MatchesProvider>().matches;
    final match = matches
        .where((m) => m.id == args.matchId)
        .cast<Fixture?>()
        .firstOrNull;
    if (match == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final teams = context.watch<TeamsProvider>().teams;
    final teamA = match.teamAId == null
        ? null
        : teams.where((t) => t.id == match.teamAId).cast<Team?>().firstOrNull;
    final teamB = match.teamBId == null
        ? null
        : teams.where((t) => t.id == match.teamBId).cast<Team?>().firstOrNull;

    final canEdit = match.status != 'finished';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.darkNavy),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSizes.hubContentMaxWidth,
                ),
                child: Padding(
                  padding: Insets.allMd,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppTopBarTextButton(
                            label: AppStrings.lineupBoardTopTitle,
                            onPressed: () => _handleBack(context),
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
                      _HeaderCard(
                        title: AppStrings.lineupBoardTitle(
                          teamA?.name ?? AppStrings.matchCenterTeamATbd,
                          teamB?.name ?? AppStrings.matchCenterTeamBTbd,
                        ),
                        subline: AppStrings.lineupBoardSubline(
                          kickOff: formatDateTimeMmDd(match.startAt),
                          fieldName:
                              _fieldName(context, match) ??
                              AppStrings.commonPlaceholderDash,
                        ),
                        canEdit: canEdit,
                        saving: _saving,
                        onSave: () => _saveAll(context, match: match),
                        onBack: () => _handleBack(context),
                      ),
                      Gaps.hMd,
                      QuickBar(
                        items: [
                          QuickBarItem(
                            label: AppStrings.lineupBoardTabLineup,
                            isSelected: _tab == _Tab.lineup,
                            onPressed: () => setState(() => _tab = _Tab.lineup),
                          ),
                          QuickBarItem(
                            label: AppStrings.lineupBoardTabTactics,
                            isSelected: _tab == _Tab.tactics,
                            onPressed: () =>
                                setState(() => _tab = _Tab.tactics),
                          ),
                          QuickBarItem(
                            label: AppStrings.lineupBoardTabLogistics,
                            isSelected: _tab == _Tab.logistics,
                            onPressed: () =>
                                setState(() => _tab = _Tab.logistics),
                          ),
                        ],
                      ),
                      Gaps.hMd,
                      Expanded(
                        child: SingleChildScrollView(
                          child: switch (_tab) {
                            _Tab.lineup => _LineupTab(
                              match: match,
                              teamA: teamA,
                              teamB: teamB,
                              teamSide: _teamSide,
                              canEdit: canEdit,
                              activeSlotIndex: _activeSlotIndex,
                              searchController: _searchController,
                              teamDrafts: _teamDrafts,
                              onDirty: () => setState(() => _dirty = true),
                              onTeamSideChanged: (side) => setState(() {
                                _teamSide = side;
                                _activeSlotIndex = null;
                              }),
                              onActiveSlotChanged: (slot) =>
                                  setState(() => _activeSlotIndex = slot),
                            ),
                            _Tab.tactics => _TacticsTab(
                              match: match,
                              canEdit: canEdit,
                              pressing: _pressing,
                              width: _width,
                              buildUp: _buildUp,
                              cornersController: _cornersController,
                              freeKicksController: _freeKicksController,
                              keyMatchupsController: _keyMatchupsController,
                              doDontDrafts: _doDontDrafts,
                              tacticsInitialized: _tacticsInitialized,
                              onInitialized: () =>
                                  setState(() => _tacticsInitialized = true),
                              onDirty: () => setState(() => _dirty = true),
                              onPressingChanged: (value) =>
                                  setState(() => _pressing = value),
                              onWidthChanged: (value) =>
                                  setState(() => _width = value),
                              onBuildUpChanged: (value) =>
                                  setState(() => _buildUp = value),
                            ),
                            _Tab.logistics => _LogisticsTab(
                              match: match,
                              teamA: teamA,
                              teamB: teamB,
                              teamSide: _teamSide,
                              canEdit: canEdit,
                              pitchFeeController: _pitchFeeController,
                              feeSplitMode: _feeSplitMode,
                              meetTime: _meetTime,
                              bringCash: _bringCash,
                              bringBibs: _bringBibs,
                              bringBall: _bringBall,
                              bringWater: _bringWater,
                              crewNotesController: _crewNotesController,
                              attendanceByTeamId: _attendanceByTeamId,
                              matchLogisticsInitialized:
                                  _matchLogisticsInitialized,
                              onMatchLogisticsInitialized: () => setState(
                                () => _matchLogisticsInitialized = true,
                              ),
                              onDirty: () => setState(() => _dirty = true),
                              onTeamSideChanged: (side) => setState(() {
                                _teamSide = side;
                                _activeSlotIndex = null;
                              }),
                              onFeeSplitModeChanged: (mode) => setState(() {
                                _feeSplitMode = mode;
                                _dirty = true;
                              }),
                              onMeetTimeChanged: (value) => setState(() {
                                _meetTime = value;
                                _dirty = true;
                              }),
                              onBringCashChanged: (value) => setState(() {
                                _bringCash = value;
                                _dirty = true;
                              }),
                              onBringBibsChanged: (value) => setState(() {
                                _bringBibs = value;
                                _dirty = true;
                              }),
                              onBringBallChanged: (value) => setState(() {
                                _bringBall = value;
                                _dirty = true;
                              }),
                              onBringWaterChanged: (value) => setState(() {
                                _bringWater = value;
                                _dirty = true;
                              }),
                              onAttendanceChanged:
                                  (teamId, playerId, isComing) {
                                    setState(() {
                                      (_attendanceByTeamId[teamId] ??=
                                              {})[playerId] =
                                          isComing;
                                      _dirty = true;
                                    });
                                  },
                              onCopySummary: () => _copySummary(
                                context,
                                match: match,
                                teamA: teamA,
                                teamB: teamB,
                              ),
                              onBack: () => _handleBack(context),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBack(BuildContext context) async {
    if (!_dirty) {
      await Navigator.of(context).maybePop();
      return;
    }

    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkNavy,
        title: const Text(AppStrings.lineupBoardDiscardTitle),
        content: const SizedBox.shrink(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.lineupBoardKeepEditing),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppStrings.lineupBoardDiscard),
          ),
        ],
      ),
    );

    if (discard == true && context.mounted) {
      await Navigator.of(context).maybePop();
    }
  }

  Future<void> _saveAll(
    BuildContext context, {
    required Fixture match,
  }) async {
    if (_saving) return;
    setState(() => _saving = true);

    final lineupProvider = context.read<LineupProvider>();
    final tacticsProvider = context.read<TacticsProvider>();

    try {
      final teamAId = match.teamAId;
      final teamBId = match.teamBId;
      final teamIds = [
        if (teamAId != null) teamAId,
        if (teamBId != null) teamBId,
      ];

      for (final teamId in teamIds) {
        final draft = _teamDrafts[teamId];
        if (draft == null) continue;

        await lineupProvider.upsertLineup(
          matchId: match.id,
          teamId: teamId,
          formation: draft.formation,
        );

        await lineupProvider.replaceLineupSlots(
          matchId: match.id,
          teamId: teamId,
          entries: [
            for (var i = 0; i < draft.positions.length; i++)
              LineupSlotsCompanion.insert(
                matchId: match.id,
                teamId: teamId,
                slotIndex: i,
                position: Value(draft.positions[i]),
                playerId: Value(draft.playerIds[i]),
              ),
          ],
        );
      }

      await tacticsProvider.upsertTactics(
        matchId: match.id,
        pressing: _pressing,
        width: _width,
        buildUp: _buildUp,
        corners: _cornersController.text.trim().isEmpty
            ? null
            : _cornersController.text.trim(),
        freeKicks: _freeKicksController.text.trim().isEmpty
            ? null
            : _freeKicksController.text.trim(),
        keyMatchups: _keyMatchupsController.text.trim().isEmpty
            ? null
            : _keyMatchupsController.text.trim(),
      );

      for (final item in _doDontDrafts) {
        if (item.id == null) {
          if (item.deleted) continue;
          await tacticsProvider.addDoDontItem(
            matchId: match.id,
            content: item.content,
            isDone: item.isDone,
            sortOrder: item.sortOrder,
          );
          continue;
        }

        if (item.deleted) {
          await tacticsProvider.deleteDoDontItemById(item.id!);
          continue;
        }

        await tacticsProvider.updateDoDontItem(
          DoDontItem(
            id: item.id!,
            matchId: match.id,
            content: item.content,
            isDone: item.isDone,
            sortOrder: item.sortOrder,
          ),
        );
      }

      for (final entry in _attendanceByTeamId.entries) {
        final teamId = entry.key;
        final attendanceByPlayerId = entry.value;
        if (attendanceByPlayerId.isEmpty) continue;

        for (final playerEntry in attendanceByPlayerId.entries) {
          await lineupProvider.setAttendance(
            matchId: match.id,
            teamId: teamId,
            playerId: playerEntry.key,
            isComing: playerEntry.value,
          );
        }
      }

      await lineupProvider.upsertMatchLogistics(
        matchId: match.id,
        pitchFeeTotal: _parseFee(_pitchFeeController.text),
        splitMode: _feeSplitMode == _FeeSplitMode.confirmedOnly
            ? 'confirmed'
            : 'all',
        meetTime: _meetTime,
        bringCash: _bringCash,
        bringBibs: _bringBibs,
        bringBall: _bringBall,
        bringWater: _bringWater,
        crewNotes: _crewNotesController.text.trim().isEmpty
            ? null
            : _crewNotesController.text.trim(),
      );

      if (!mounted) return;
      setState(() {
        _dirty = false;
        _saving = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
    }
  }

  Future<void> _copySummary(
    BuildContext context, {
    required Fixture match,
    required Team? teamA,
    required Team? teamB,
  }) async {
    final selectedTeamId = offeredTeamId(match, teamSide: _teamSide);
    final players = selectedTeamId == null
        ? const <Player>[]
        : await context
              .read<TeamsProvider>()
              .watchPlayersByTeam(selectedTeamId)
              .first;

    final teamAttendance = selectedTeamId == null
        ? const <int, bool>{}
        : (_attendanceByTeamId[selectedTeamId] ?? const <int, bool>{});
    final confirmedCount = players
        .where((p) => teamAttendance[p.id] == true)
        .length;
    final totalCount = players.length;

    final perPlayer = feePerPlayer(
      total: _parseFee(_pitchFeeController.text),
      confirmedCount: confirmedCount,
      rosterCount: totalCount,
      mode: _feeSplitMode,
    );

    final summary = StringBuffer()
      ..writeln(
        AppStrings.lineupBoardSummaryHeader(
          teamA?.name ?? AppStrings.matchCenterTeamATbd,
          teamB?.name ?? AppStrings.matchCenterTeamBTbd,
        ),
      )
      ..writeln(
        AppStrings.lineupBoardSummaryKickoff(
          formatDateTimeMmDd(match.startAt),
        ),
      )
      ..writeln(
        AppStrings.lineupBoardSummaryField(
          _fieldName(context, match) ?? AppStrings.commonPlaceholderDash,
        ),
      )
      ..writeln(
        AppStrings.lineupBoardSummaryConfirmed(confirmedCount, totalCount),
      )
      ..writeln(AppStrings.lineupBoardSummaryFeePerPlayer(perPlayer));

    final crewNotes = _crewNotesController.text.trim();
    if (crewNotes.isNotEmpty) {
      summary.writeln(AppStrings.lineupBoardSummaryCrewNotes(crewNotes));
    }

    await Clipboard.setData(ClipboardData(text: summary.toString().trim()));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.lineupBoardCopied)),
    );
  }

  String? _fieldName(BuildContext context, Fixture match) {
    final fields = context.read<FieldsProvider>().fields;
    if (match.fieldId == null) return null;
    return fields
        .where((f) => f.id == match.fieldId)
        .map((f) => f.name)
        .cast<String?>()
        .firstWhere((n) => n != null, orElse: () => null);
  }

  double? _parseFee(String raw) => parseFee(raw);
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.title,
    required this.subline,
    required this.canEdit,
    required this.saving,
    required this.onSave,
    required this.onBack,
  });

  final String title;
  final String subline;
  final bool canEdit;
  final bool saving;
  final VoidCallback onSave;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      padding: Insets.allMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Gaps.hXs,
          Text(
            subline,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteOverlay70,
            ),
          ),
          Gaps.hMd,
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: AppSizes.hubPillButtonHeight,
                  child: AppPillButton(
                    label: AppStrings.commonSave,
                    onPressed: canEdit && !saving ? onSave : () {},
                    backgroundColor: AppColors.limeGreen,
                    textColor: AppColors.darkNavy,
                  ),
                ),
              ),
              Gaps.wSm,
              Expanded(
                child: SizedBox(
                  height: AppSizes.hubPillButtonHeight,
                  child: AppPillButton(
                    label: AppStrings.onboardingBack,
                    onPressed: onBack,
                    backgroundColor: AppColors.darkRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _Tab { lineup, tactics, logistics }

enum _TeamSide { a, b }

enum _FeeSplitMode { confirmedOnly, allRoster }

class _TeamDraft {
  const _TeamDraft({
    required this.formation,
    required this.positions,
    required this.playerIds,
  });

  final String formation;
  final List<String> positions;
  final List<int?> playerIds;

  _TeamDraft copyWith({
    String? formation,
    List<String>? positions,
    List<int?>? playerIds,
  }) {
    return _TeamDraft(
      formation: formation ?? this.formation,
      positions: positions ?? this.positions,
      playerIds: playerIds ?? this.playerIds,
    );
  }
}

class _DoDontDraft {
  _DoDontDraft({
    required this.id,
    required this.content,
    required this.isDone,
    required this.sortOrder,
  });

  final int? id;
  String content;
  bool isDone;
  final int sortOrder;
  bool deleted = false;
}

int? offeredTeamId(Fixture match, {required _TeamSide teamSide}) =>
    teamSide == _TeamSide.a ? match.teamAId : match.teamBId;

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? firstOrNullWhere(bool Function(T) predicate) {
    for (final item in this) {
      if (predicate(item)) return item;
    }
    return null;
  }
}

double? parseFee(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;
  final value = double.tryParse(trimmed.replaceAll(',', '.'));
  if (value == null || value.isNaN || value.isInfinite) return null;
  if (value < 0) return null;
  return value;
}

double? feePerPlayer({
  required double? total,
  required int confirmedCount,
  required int rosterCount,
  required _FeeSplitMode mode,
}) {
  if (total == null) return null;
  final denom = mode == _FeeSplitMode.confirmedOnly
      ? confirmedCount
      : rosterCount;
  if (denom <= 0) return null;
  return total / denom;
}

class LineupTacticsArgs {
  const LineupTacticsArgs({required this.matchId});
  final int matchId;
}

class _LineupTab extends StatefulWidget {
  const _LineupTab({
    required this.match,
    required this.teamA,
    required this.teamB,
    required this.teamSide,
    required this.canEdit,
    required this.activeSlotIndex,
    required this.searchController,
    required this.teamDrafts,
    required this.onDirty,
    required this.onTeamSideChanged,
    required this.onActiveSlotChanged,
  });

  final Fixture match;
  final Team? teamA;
  final Team? teamB;
  final _TeamSide teamSide;
  final bool canEdit;
  final int? activeSlotIndex;
  final TextEditingController searchController;
  final Map<int, _TeamDraft> teamDrafts;
  final VoidCallback onDirty;
  final ValueChanged<_TeamSide> onTeamSideChanged;
  final ValueChanged<int?> onActiveSlotChanged;

  @override
  State<_LineupTab> createState() => _LineupTabState();
}

class _LineupTabState extends State<_LineupTab> {
  @override
  Widget build(BuildContext context) {
    final teamId = offeredTeamId(widget.match, teamSide: widget.teamSide);
    final effectiveTeamId = teamId ?? widget.match.teamAId;
    if (effectiveTeamId == null) return const SizedBox.shrink();

    final teamBDisabled = widget.match.teamBId == null;
    final kitColors = resolveKitColors(
      teamA: widget.teamA,
      teamB: widget.teamB,
      side: widget.teamSide,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TeamSideSwitcher(
          teamAName: widget.teamA?.name ?? AppStrings.matchCenterTeamATbd,
          teamBName: widget.teamB?.name ?? AppStrings.matchCenterTeamBTbd,
          teamSide: widget.teamSide,
          teamBDisabled: teamBDisabled,
          onChanged: (side) {
            if (side == _TeamSide.b && teamBDisabled) return;
            widget.onTeamSideChanged(side);
          },
        ),
        if (teamBDisabled) ...[
          Gaps.hSm,
          Text(
            AppStrings.lineupBoardTeamBNotAssigned,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteOverlay70,
            ),
          ),
        ],
        Gaps.hMd,
        StreamBuilder<Lineup?>(
          stream: context.read<LineupProvider>().watchLineup(
            widget.match.id,
            effectiveTeamId,
          ),
          builder: (context, lineupSnapshot) {
            final formationFromDb =
                lineupSnapshot.data?.formation ??
                AppStrings.lineupBoardFormation442;

            return StreamBuilder<List<LineupSlot>>(
              stream: context.read<LineupProvider>().watchLineupSlots(
                widget.match.id,
                effectiveTeamId,
              ),
              builder: (context, slotSnapshot) {
                final draft = _ensureDraft(
                  teamId: effectiveTeamId,
                  formationFromDb: formationFromDb,
                  slotsFromDb: slotSnapshot.data ?? const [],
                );

                return StreamBuilder<List<Player>>(
                  stream: context.read<TeamsProvider>().watchPlayersByTeam(
                    effectiveTeamId,
                  ),
                  builder: (context, rosterSnapshot) {
                    final roster = rosterSnapshot.data ?? const <Player>[];
                    final visibleRoster = _filterPlayers(
                      roster,
                      query: widget.searchController.text,
                    );

                    final assignedIds = draft.playerIds
                        .whereType<int>()
                        .toSet();
                    final available = visibleRoster
                        .where((p) => !assignedIds.contains(p.id))
                        .toList();

                    final warnings = _lineupWarnings(draft);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FormationRow(
                          formation: draft.formation,
                          canEdit: widget.canEdit,
                          onChanged: widget.canEdit
                              ? (value) {
                                  if (value == null) return;
                                  _updateFormation(
                                    teamId: effectiveTeamId,
                                    formation: value,
                                  );
                                  widget.onDirty();
                                }
                              : null,
                        ),
                        Gaps.hSm,
                        Text(
                          AppStrings.lineupBoardFormationNote,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.whiteOverlay70,
                              ),
                        ),
                        Gaps.hMd,
                        _PitchBoard(
                          positions: draft.positions,
                          playerIds: draft.playerIds,
                          roster: roster,
                          kitColors: kitColors,
                          activeSlotIndex: widget.activeSlotIndex,
                          canEdit: widget.canEdit,
                          onSlotTap: (index) {
                            if (!widget.canEdit) return;
                            final current = draft.playerIds[index];
                            if (current != null) {
                              _setSlotPlayer(
                                teamId: effectiveTeamId,
                                slotIndex: index,
                                playerId: null,
                              );
                              widget.onActiveSlotChanged(null);
                              widget.onDirty();
                              return;
                            }
                            widget.onActiveSlotChanged(index);
                          },
                        ),
                        if (warnings.isNotEmpty) ...[
                          Gaps.hSm,
                          for (final warning in warnings) ...[
                            Text(
                              warning,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.statsScheduled),
                            ),
                            if (warning != warnings.last) Gaps.hXs,
                          ],
                        ],
                        Gaps.hMd,
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: AppSizes.hubPillButtonHeight,
                                child: AppPillButton(
                                  label: AppStrings.lineupBoardAutoArrange,
                                  onPressed: widget.canEdit
                                      ? () {
                                          _autoArrange(
                                            teamId: effectiveTeamId,
                                            roster: roster,
                                          );
                                          widget.onActiveSlotChanged(null);
                                          widget.onDirty();
                                        }
                                      : () {},
                                  backgroundColor: AppColors.limeGreen,
                                  textColor: AppColors.darkNavy,
                                ),
                              ),
                            ),
                            Gaps.wSm,
                            Expanded(
                              child: SizedBox(
                                height: AppSizes.hubPillButtonHeight,
                                child: AppPillButton(
                                  label: AppStrings.lineupBoardClearLineup,
                                  onPressed: widget.canEdit
                                      ? () {
                                          _clearLineup(teamId: effectiveTeamId);
                                          widget.onActiveSlotChanged(null);
                                          widget.onDirty();
                                        }
                                      : () {},
                                  backgroundColor: AppColors.darkRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.hMd,
                        AppPillTextField(
                          controller: widget.searchController,
                          hintText: AppStrings.lineupBoardSearchPlayersHint,
                          suffixIconAsset: AppIcons.search,
                          enabled: widget.canEdit,
                        ),
                        Gaps.hMd,
                        Text(
                          AppStrings.lineupBoardAvailableTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Gaps.hSm,
                        _AvailablePlayersRow(
                          players: available,
                          onTap: widget.canEdit
                              ? (player) {
                                  final slot = widget.activeSlotIndex;
                                  if (slot == null) return;
                                  _setSlotPlayer(
                                    teamId: effectiveTeamId,
                                    slotIndex: slot,
                                    playerId: player.id,
                                  );
                                  widget.onActiveSlotChanged(null);
                                  widget.onDirty();
                                }
                              : null,
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        Gaps.hXl,
      ],
    );
  }

  _TeamDraft _ensureDraft({
    required int teamId,
    required String formationFromDb,
    required List<LineupSlot> slotsFromDb,
  }) {
    final existing = widget.teamDrafts[teamId];
    if (existing != null) return existing;

    final positions = formationToPositions(formationFromDb);
    final playerIds = List<int?>.filled(positions.length, null);
    for (final slot in slotsFromDb) {
      if (slot.slotIndex < 0 || slot.slotIndex >= playerIds.length) continue;
      playerIds[slot.slotIndex] = slot.playerId;
    }

    final created = _TeamDraft(
      formation: formationFromDb,
      positions: positions,
      playerIds: playerIds,
    );
    widget.teamDrafts[teamId] = created;
    return created;
  }

  void _updateFormation({required int teamId, required String formation}) {
    final draft = widget.teamDrafts[teamId];
    if (draft == null) return;

    final nextPositions = formationToPositions(formation);
    final nextPlayerIds = List<int?>.filled(nextPositions.length, null);

    final used = <int>{};
    for (var i = 0; i < nextPositions.length; i++) {
      final desiredPosition = nextPositions[i];
      for (var j = 0; j < draft.positions.length; j++) {
        if (draft.positions[j] != desiredPosition) continue;
        final id = draft.playerIds[j];
        if (id == null || used.contains(id)) continue;
        nextPlayerIds[i] = id;
        used.add(id);
        break;
      }
    }

    widget.teamDrafts[teamId] = draft.copyWith(
      formation: formation,
      positions: nextPositions,
      playerIds: nextPlayerIds,
    );
    setState(() {});
  }

  void _setSlotPlayer({
    required int teamId,
    required int slotIndex,
    required int? playerId,
  }) {
    final draft = widget.teamDrafts[teamId];
    if (draft == null) return;

    final nextPlayerIds = [...draft.playerIds];
    if (playerId != null) {
      for (var i = 0; i < nextPlayerIds.length; i++) {
        if (nextPlayerIds[i] == playerId) nextPlayerIds[i] = null;
      }
    }
    nextPlayerIds[slotIndex] = playerId;

    widget.teamDrafts[teamId] = draft.copyWith(playerIds: nextPlayerIds);
    setState(() {});
  }

  void _autoArrange({required int teamId, required List<Player> roster}) {
    final draft = widget.teamDrafts[teamId];
    if (draft == null) return;

    final remaining = [...roster];
    final nextPlayerIds = List<int?>.filled(draft.positions.length, null);

    for (var i = 0; i < draft.positions.length; i++) {
      final desired = draft.positions[i];
      final match = remaining.firstOrNullWhere(
        (p) => normalizePosition(p.position) == desired,
      );
      if (match == null) continue;
      nextPlayerIds[i] = match.id;
      remaining.remove(match);
    }

    for (var i = 0; i < nextPlayerIds.length; i++) {
      if (nextPlayerIds[i] != null) continue;
      if (remaining.isEmpty) break;
      nextPlayerIds[i] = remaining.removeAt(0).id;
    }

    widget.teamDrafts[teamId] = draft.copyWith(playerIds: nextPlayerIds);
    setState(() {});
  }

  void _clearLineup({required int teamId}) {
    final draft = widget.teamDrafts[teamId];
    if (draft == null) return;
    widget.teamDrafts[teamId] = draft.copyWith(
      playerIds: List<int?>.filled(draft.playerIds.length, null),
    );
    setState(() {});
  }

  List<String> _lineupWarnings(_TeamDraft draft) {
    final warnings = <String>[];

    final hasGoalkeeper = draft.positions.asMap().entries.any((entry) {
      if (entry.value != 'GK') return false;
      return draft.playerIds[entry.key] != null;
    });
    if (!hasGoalkeeper) {
      warnings.add(AppStrings.lineupBoardWarningNoGoalkeeper);
    }

    if (draft.playerIds.any((id) => id == null)) {
      warnings.add(AppStrings.lineupBoardWarningIncomplete);
    }

    return warnings;
  }

  List<Player> _filterPlayers(List<Player> players, {required String query}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return players;
    return players.where((p) => p.name.toLowerCase().contains(q)).toList();
  }
}

class _TeamSideSwitcher extends StatelessWidget {
  const _TeamSideSwitcher({
    required this.teamAName,
    required this.teamBName,
    required this.teamSide,
    required this.teamBDisabled,
    required this.onChanged,
  });

  final String teamAName;
  final String teamBName;
  final _TeamSide teamSide;
  final bool teamBDisabled;
  final ValueChanged<_TeamSide> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      padding: Insets.allXs,
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: teamSide == _TeamSide.a
                    ? AppColors.primaryBlue
                    : AppColors.whiteOverlay20,
                shape: const StadiumBorder(),
                padding: EdgeInsets.zero,
              ),
              onPressed: () => onChanged(_TeamSide.a),
              child: Text(
                teamAName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Gaps.wSm,
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: teamSide == _TeamSide.b
                    ? AppColors.primaryBlue
                    : AppColors.whiteOverlay20,
                shape: const StadiumBorder(),
                padding: EdgeInsets.zero,
              ),
              onPressed: teamBDisabled ? null : () => onChanged(_TeamSide.b),
              child: Text(
                teamBName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormationRow extends StatelessWidget {
  const _FormationRow({
    required this.formation,
    required this.canEdit,
    required this.onChanged,
  });

  final String formation;
  final bool canEdit;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return _PillPickerButton(
      label: AppStrings.lineupBoardFormationLabel,
      value: formation,
      enabled: canEdit,
      onPressed: onChanged == null
          ? null
          : () async {
              final selected = await _showPickerSheet<String>(
                context,
                title: AppStrings.lineupBoardFormationLabel,
                items: const [
                  _PickerOption(
                    value: AppStrings.lineupBoardFormation442,
                    label: AppStrings.lineupBoardFormation442,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardFormation433,
                    label: AppStrings.lineupBoardFormation433,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardFormation352,
                    label: AppStrings.lineupBoardFormation352,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardFormation532,
                    label: AppStrings.lineupBoardFormation532,
                  ),
                ],
              );
              onChanged?.call(selected);
            },
    );
  }
}

class _PillPickerButton extends StatelessWidget {
  const _PillPickerButton({
    required this.label,
    required this.value,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final String? value;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.hubPillButtonHeight,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.whiteOverlay20,
          shape: const StadiumBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: enabled ? onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value == null || value!.isEmpty ? label : value!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.wXs,
            SvgPicture.asset(
              AppIcons.chevronDown,
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

class _PitchBoard extends StatelessWidget {
  const _PitchBoard({
    required this.positions,
    required this.playerIds,
    required this.roster,
    required this.kitColors,
    required this.activeSlotIndex,
    required this.canEdit,
    required this.onSlotTap,
  });

  final List<String> positions;
  final List<int?> playerIds;
  final List<Player> roster;
  final _KitColors kitColors;
  final int? activeSlotIndex;
  final bool canEdit;
  final ValueChanged<int> onSlotTap;

  @override
  Widget build(BuildContext context) {
    final slotsByPos = <String, List<_SlotModel>>{
      'GK': [],
      'DF': [],
      'MF': [],
      'FW': [],
    };

    for (var i = 0; i < positions.length; i++) {
      final pos = positions[i];
      final playerId = playerIds[i];
      final player = playerId == null
          ? null
          : roster.where((p) => p.id == playerId).cast<Player?>().firstOrNull;
      slotsByPos[pos]?.add(
        _SlotModel(index: i, pos: pos, player: player),
      );
    }

    return ClipRRect(
      borderRadius: AppRadius.lg,
      child: AspectRatio(
        aspectRatio: AppSizes.lineupPitchAspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppImages.lineupBoardPitch, fit: BoxFit.cover),
            Padding(
              padding: Insets.allMd,
              child: Column(
                children: [
                  _SlotRow(
                    slots: slotsByPos['FW']!,
                    kitColors: kitColors,
                    activeSlotIndex: activeSlotIndex,
                    canEdit: canEdit,
                    onSlotTap: onSlotTap,
                  ),
                  const Spacer(),
                  _SlotRow(
                    slots: slotsByPos['MF']!,
                    kitColors: kitColors,
                    activeSlotIndex: activeSlotIndex,
                    canEdit: canEdit,
                    onSlotTap: onSlotTap,
                  ),
                  const Spacer(),
                  _SlotRow(
                    slots: slotsByPos['DF']!,
                    kitColors: kitColors,
                    activeSlotIndex: activeSlotIndex,
                    canEdit: canEdit,
                    onSlotTap: onSlotTap,
                  ),
                  const Spacer(),
                  _SlotRow(
                    slots: slotsByPos['GK']!,
                    kitColors: kitColors,
                    activeSlotIndex: activeSlotIndex,
                    canEdit: canEdit,
                    onSlotTap: onSlotTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlotRow extends StatelessWidget {
  const _SlotRow({
    required this.slots,
    required this.kitColors,
    required this.activeSlotIndex,
    required this.canEdit,
    required this.onSlotTap,
  });

  final List<_SlotModel> slots;
  final _KitColors kitColors;
  final int? activeSlotIndex;
  final bool canEdit;
  final ValueChanged<int> onSlotTap;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        for (final slot in slots) ...[
          Expanded(
            child: _PitchSlot(
              slot: slot,
              kitColors: kitColors,
              isActive: activeSlotIndex == slot.index,
              canEdit: canEdit,
              onTap: () => onSlotTap(slot.index),
            ),
          ),
          if (slot != slots.last) Gaps.wSm,
        ],
      ],
    );
  }
}

class _PitchSlot extends StatelessWidget {
  const _PitchSlot({
    required this.slot,
    required this.kitColors,
    required this.isActive,
    required this.canEdit,
    required this.onTap,
  });

  final _SlotModel slot;
  final _KitColors kitColors;
  final bool isActive;
  final bool canEdit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final player = slot.player;
    return InkWell(
      onTap: canEdit ? onTap : null,
      borderRadius: AppRadius.card,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.whiteOverlay20 : AppColors.whiteOverlay10,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
        padding: Insets.allSm,
        child: player == null
            ? Center(
                child: Text(
                  slot.pos,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TintedKitIcon(
                    colors: kitColors,
                    size: AppSizes.lineupSlotKitSize,
                  ),
                  Gaps.hXs,
                  Text(
                    player.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (player.number != null) ...[
                    Gaps.hXs,
                    Text(
                      '#${player.number}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteOverlay70,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

class _SlotModel {
  const _SlotModel({
    required this.index,
    required this.pos,
    required this.player,
  });

  final int index;
  final String pos;
  final Player? player;
}

class _AvailablePlayersRow extends StatelessWidget {
  const _AvailablePlayersRow({required this.players, required this.onTap});

  final List<Player> players;
  final ValueChanged<Player>? onTap;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: AppSizes.lineupAvailablePlayerHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: players.length,
        separatorBuilder: (_, __) => Gaps.wSm,
        itemBuilder: (context, index) {
          final player = players[index];
          return _PlayerChip(
            player: player,
            onTap: onTap == null ? null : () => onTap!(player),
          );
        },
      ),
    );
  }
}

class _PlayerChip extends StatelessWidget {
  const _PlayerChip({required this.player, required this.onTap});

  final Player player;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.pill,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteOverlay10,
          borderRadius: AppRadius.pill,
          border: Border.all(color: AppColors.whiteOverlay20),
        ),
        padding: Insets.allSm,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: AppSizes.lineupPlayerNumberDotSize,
              width: AppSizes.lineupPlayerNumberDotSize,
              decoration: const BoxDecoration(
                color: AppColors.whiteOverlay20,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  player.number?.toString() ?? AppStrings.commonPlaceholderDash,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Gaps.wSm,
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: AppSizes.lineupPlayerChipMinWidth,
              ),
              child: Text(
                player.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerOption<T> {
  const _PickerOption({required this.value, required this.label});
  final T value;
  final String label;
}

Future<T?> _showPickerSheet<T>(
  BuildContext context, {
  required String title,
  required List<_PickerOption<T>> items,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: AppColors.darkNavy,
    builder: (context) {
      return Padding(
        padding: Insets.allMd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.darkNavy,
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            border: Border.all(color: AppColors.whiteOverlay20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: Insets.allMd,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Divider(height: 1, color: AppColors.whiteOverlay20),
              for (final item in items) ...[
                ListTile(
                  title: Text(
                    item.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () => Navigator.of(context).pop(item.value),
                ),
                if (item != items.last)
                  const Divider(height: 1, color: AppColors.whiteOverlay20),
              ],
            ],
          ),
        ),
      );
    },
  );
}

List<String> formationToPositions(String formation) {
  return switch (formation) {
    AppStrings.lineupBoardFormation442 => const [
      'GK',
      'DF',
      'DF',
      'DF',
      'DF',
      'MF',
      'MF',
      'MF',
      'MF',
      'FW',
      'FW',
    ],
    AppStrings.lineupBoardFormation433 => const [
      'GK',
      'DF',
      'DF',
      'DF',
      'DF',
      'MF',
      'MF',
      'MF',
      'FW',
      'FW',
      'FW',
    ],
    AppStrings.lineupBoardFormation352 => const [
      'GK',
      'DF',
      'DF',
      'DF',
      'MF',
      'MF',
      'MF',
      'MF',
      'MF',
      'FW',
      'FW',
    ],
    AppStrings.lineupBoardFormation532 => const [
      'GK',
      'DF',
      'DF',
      'DF',
      'DF',
      'DF',
      'MF',
      'MF',
      'MF',
      'FW',
      'FW',
    ],
    _ => formationToPositions(AppStrings.lineupBoardFormation442),
  };
}

String normalizePosition(String? raw) {
  final upper = (raw ?? '').trim().toUpperCase();
  if (upper.contains('GK')) return 'GK';
  if (upper.contains('DF') || upper.contains('DEF')) return 'DF';
  if (upper.contains('MF') || upper.contains('MID')) return 'MF';
  if (upper.contains('FW') || upper.contains('FWD') || upper.contains('ST')) {
    return 'FW';
  }
  return '';
}

class _KitColors {
  const _KitColors({required this.primary, required this.secondary});
  final Color primary;
  final Color secondary;
}

_KitColors resolveKitColors({
  required Team? teamA,
  required Team? teamB,
  required _TeamSide side,
}) {
  final fallbackPrimary = AppColors.primaryBlue;
  final fallbackSecondary = AppColors.white;

  if (side == _TeamSide.a) {
    return _teamKitColors(
      teamA,
      primaryFallback: fallbackPrimary,
      secondaryFallback: fallbackSecondary,
      isAway: false,
    );
  }

  final useAway = teamA != null && teamB != null
      ? _colorsSimilar(
          _intToColor(teamA.homePrimaryColor, fallbackPrimary),
          _intToColor(teamB.homePrimaryColor, fallbackPrimary),
        )
      : false;

  return _teamKitColors(
    teamB,
    primaryFallback: fallbackPrimary,
    secondaryFallback: fallbackSecondary,
    isAway: useAway,
  );
}

_KitColors _teamKitColors(
  Team? team, {
  required Color primaryFallback,
  required Color secondaryFallback,
  required bool isAway,
}) {
  if (team == null) {
    return _KitColors(primary: primaryFallback, secondary: secondaryFallback);
  }

  final primary = _intToColor(
    isAway ? team.awayPrimaryColor : team.homePrimaryColor,
    primaryFallback,
  );
  final secondary = _intToColor(
    isAway ? team.awaySecondaryColor : team.homeSecondaryColor,
    secondaryFallback,
  );
  return _KitColors(primary: primary, secondary: secondary);
}

Color _intToColor(int? argb, Color fallback) =>
    argb == null ? fallback : Color(argb);

bool _colorsSimilar(Color a, Color b) {
  int to8(double v) {
    final value = (v * 255.0).round();
    if (value < 0) return 0;
    if (value > 255) return 255;
    return value;
  }

  final dr = to8(a.r) - to8(b.r);
  final dg = to8(a.g) - to8(b.g);
  final db = to8(a.b) - to8(b.b);
  final distSq = dr * dr + dg * dg + db * db;
  const thresholdSq = 90 * 90;
  return distSq < thresholdSq;
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      padding: Insets.allMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Gaps.hSm,
          child,
        ],
      ),
    );
  }
}

class _TacticsTab extends StatefulWidget {
  const _TacticsTab({
    required this.match,
    required this.canEdit,
    required this.pressing,
    required this.width,
    required this.buildUp,
    required this.cornersController,
    required this.freeKicksController,
    required this.keyMatchupsController,
    required this.doDontDrafts,
    required this.tacticsInitialized,
    required this.onInitialized,
    required this.onDirty,
    required this.onPressingChanged,
    required this.onWidthChanged,
    required this.onBuildUpChanged,
  });

  final Fixture match;
  final bool canEdit;
  final String? pressing;
  final String? width;
  final String? buildUp;

  final TextEditingController cornersController;
  final TextEditingController freeKicksController;
  final TextEditingController keyMatchupsController;

  final List<_DoDontDraft> doDontDrafts;
  final bool tacticsInitialized;
  final VoidCallback onInitialized;
  final VoidCallback onDirty;

  final ValueChanged<String?> onPressingChanged;
  final ValueChanged<String?> onWidthChanged;
  final ValueChanged<String?> onBuildUpChanged;

  @override
  State<_TacticsTab> createState() => _TacticsTabState();
}

class _TacticsTabState extends State<_TacticsTab> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<TacticsProvider>();

    return StreamBuilder<Tactic?>(
      stream: provider.watchTactics(widget.match.id),
      builder: (context, tacticsSnapshot) {
        return StreamBuilder<List<DoDontItem>>(
          stream: provider.watchDoDontItems(widget.match.id),
          builder: (context, doDontSnapshot) {
            _maybeInitFromDb(
              context,
              tactic: tacticsSnapshot.data,
              doDont: doDontSnapshot.data,
              tacticsState: tacticsSnapshot.connectionState,
              doDontState: doDontSnapshot.connectionState,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StyleControlsRow(
                  enabled: widget.canEdit,
                  pressing: widget.pressing,
                  width: widget.width,
                  buildUp: widget.buildUp,
                  onPressingChanged: (value) {
                    widget.onPressingChanged(value);
                    widget.onDirty();
                  },
                  onWidthChanged: (value) {
                    widget.onWidthChanged(value);
                    widget.onDirty();
                  },
                  onBuildUpChanged: (value) {
                    widget.onBuildUpChanged(value);
                    widget.onDirty();
                  },
                ),
                Gaps.hMd,
                _SectionCard(
                  title: AppStrings.lineupBoardSetPiecesNotesTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.lineupBoardCornersLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Gaps.hSm,
                      AppTextAreaField(
                        controller: widget.cornersController,
                        hintText: AppStrings.lineupBoardNotesHint,
                        enabled: widget.canEdit,
                      ),
                      Gaps.hMd,
                      Text(
                        AppStrings.lineupBoardFreeKicksLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Gaps.hSm,
                      AppTextAreaField(
                        controller: widget.freeKicksController,
                        hintText: AppStrings.lineupBoardNotesHint,
                        enabled: widget.canEdit,
                      ),
                    ],
                  ),
                ),
                Gaps.hMd,
                _SectionCard(
                  title: AppStrings.lineupBoardQuickMatchNotesTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.lineupBoardKeyMatchupsLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Gaps.hSm,
                      AppTextAreaField(
                        controller: widget.keyMatchupsController,
                        hintText: AppStrings.lineupBoardNotesHint,
                        enabled: widget.canEdit,
                      ),
                      Gaps.hMd,
                      Row(
                        children: [
                          Text(
                            AppStrings.lineupBoardDoDontTitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          SizedBox(
                            height: AppSizes.hubPillButtonHeight,
                            child: AppPillButton(
                              label: AppStrings.commonAdd,
                              onPressed: widget.canEdit ? _addDoDont : () {},
                              backgroundColor: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                      Gaps.hSm,
                      _DoDontList(
                        items: widget.doDontDrafts,
                        enabled: widget.canEdit,
                        onToggle: (item) {
                          setState(() => item.isDone = !item.isDone);
                          widget.onDirty();
                        },
                        onDelete: (item) {
                          setState(() => item.deleted = true);
                          widget.onDirty();
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.hXl,
              ],
            );
          },
        );
      },
    );
  }

  void _maybeInitFromDb(
    BuildContext context, {
    required Tactic? tactic,
    required List<DoDontItem>? doDont,
    required ConnectionState tacticsState,
    required ConnectionState doDontState,
  }) {
    if (widget.tacticsInitialized) return;
    if (tacticsState == ConnectionState.waiting) return;
    if (doDontState == ConnectionState.waiting) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.tacticsInitialized) return;

      final root = context
          .findAncestorStateOfType<_LineupTacticsBoardPageState>();
      if (root == null || !root.mounted) return;

      root.setState(() {
        root._suppressDirty = true;
        root._pressing = tactic?.pressing;
        root._width = tactic?.width;
        root._buildUp = tactic?.buildUp;
        root._cornersController.text = tactic?.corners ?? '';
        root._freeKicksController.text = tactic?.freeKicks ?? '';
        root._keyMatchupsController.text = tactic?.keyMatchups ?? '';

        root._doDontDrafts
          ..clear()
          ..addAll([
            for (final item in doDont ?? const <DoDontItem>[])
              _DoDontDraft(
                id: item.id,
                content: item.content,
                isDone: item.isDone,
                sortOrder: item.sortOrder,
              ),
          ]);
        root._suppressDirty = false;
      });

      widget.onInitialized();
    });
  }

  Future<void> _addDoDont() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkNavy,
        title: const Text(AppStrings.lineupBoardAddDoDontTitle),
        content: AppPillTextField(
          controller: controller,
          hintText: AppStrings.lineupBoardAddDoDontHint,
          suffixIconAsset: null,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text(AppStrings.commonAdd),
          ),
        ],
      ),
    );
    controller.dispose();

    final text = result?.trim() ?? '';
    if (text.isEmpty) return;

    widget.doDontDrafts.add(
      _DoDontDraft(
        id: null,
        content: text,
        isDone: false,
        sortOrder: widget.doDontDrafts.length,
      ),
    );

    widget.onDirty();
    if (mounted) setState(() {});
  }
}

class _StyleControlsRow extends StatelessWidget {
  const _StyleControlsRow({
    required this.enabled,
    required this.pressing,
    required this.width,
    required this.buildUp,
    required this.onPressingChanged,
    required this.onWidthChanged,
    required this.onBuildUpChanged,
  });

  final bool enabled;
  final String? pressing;
  final String? width;
  final String? buildUp;
  final ValueChanged<String?> onPressingChanged;
  final ValueChanged<String?> onWidthChanged;
  final ValueChanged<String?> onBuildUpChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PillPickerButton(
            label: AppStrings.lineupBoardPressingLabel,
            value: pressing,
            enabled: enabled,
            onPressed: () async {
              final selected = await _showPickerSheet<String>(
                context,
                title: AppStrings.lineupBoardPressingLabel,
                items: const [
                  _PickerOption(
                    value: AppStrings.lineupBoardPressingLow,
                    label: AppStrings.lineupBoardPressingLow,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardPressingMedium,
                    label: AppStrings.lineupBoardPressingMedium,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardPressingHigh,
                    label: AppStrings.lineupBoardPressingHigh,
                  ),
                ],
              );
              onPressingChanged(selected);
            },
          ),
        ),
        Gaps.wSm,
        Expanded(
          child: _PillPickerButton(
            label: AppStrings.lineupBoardWidthLabel,
            value: width,
            enabled: enabled,
            onPressed: () async {
              final selected = await _showPickerSheet<String>(
                context,
                title: AppStrings.lineupBoardWidthLabel,
                items: const [
                  _PickerOption(
                    value: AppStrings.lineupBoardWidthNarrow,
                    label: AppStrings.lineupBoardWidthNarrow,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardWidthBalanced,
                    label: AppStrings.lineupBoardWidthBalanced,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardWidthWide,
                    label: AppStrings.lineupBoardWidthWide,
                  ),
                ],
              );
              onWidthChanged(selected);
            },
          ),
        ),
        Gaps.wSm,
        Expanded(
          child: _PillPickerButton(
            label: AppStrings.lineupBoardBuildUpLabel,
            value: buildUp,
            enabled: enabled,
            onPressed: () async {
              final selected = await _showPickerSheet<String>(
                context,
                title: AppStrings.lineupBoardBuildUpLabel,
                items: const [
                  _PickerOption(
                    value: AppStrings.lineupBoardBuildUpDirect,
                    label: AppStrings.lineupBoardBuildUpDirect,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardBuildUpMixed,
                    label: AppStrings.lineupBoardBuildUpMixed,
                  ),
                  _PickerOption(
                    value: AppStrings.lineupBoardBuildUpShort,
                    label: AppStrings.lineupBoardBuildUpShort,
                  ),
                ],
              );
              onBuildUpChanged(selected);
            },
          ),
        ),
      ],
    );
  }
}

class _DoDontList extends StatelessWidget {
  const _DoDontList({
    required this.items,
    required this.enabled,
    required this.onToggle,
    required this.onDelete,
  });

  final List<_DoDontDraft> items;
  final bool enabled;
  final ValueChanged<_DoDontDraft> onToggle;
  final ValueChanged<_DoDontDraft> onDelete;

  @override
  Widget build(BuildContext context) {
    final visible = items.where((i) => !i.deleted).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (final item in visible) ...[
          Row(
            children: [
              Checkbox(
                value: item.isDone,
                onChanged: enabled ? (_) => onToggle(item) : null,
                side: const BorderSide(color: AppColors.whiteOverlay20),
              ),
              Expanded(
                child: Text(
                  item.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (enabled)
                IconButton(
                  onPressed: () => onDelete(item),
                  icon: SvgPicture.asset(
                    AppIcons.delete,
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
          if (item != visible.last)
            const Divider(height: 1, color: AppColors.whiteOverlay20),
        ],
      ],
    );
  }
}

class _LogisticsTab extends StatefulWidget {
  const _LogisticsTab({
    required this.match,
    required this.teamA,
    required this.teamB,
    required this.teamSide,
    required this.canEdit,
    required this.pitchFeeController,
    required this.feeSplitMode,
    required this.meetTime,
    required this.bringCash,
    required this.bringBibs,
    required this.bringBall,
    required this.bringWater,
    required this.crewNotesController,
    required this.attendanceByTeamId,
    required this.matchLogisticsInitialized,
    required this.onMatchLogisticsInitialized,
    required this.onDirty,
    required this.onTeamSideChanged,
    required this.onFeeSplitModeChanged,
    required this.onMeetTimeChanged,
    required this.onBringCashChanged,
    required this.onBringBibsChanged,
    required this.onBringBallChanged,
    required this.onBringWaterChanged,
    required this.onAttendanceChanged,
    required this.onCopySummary,
    required this.onBack,
  });

  final Fixture match;
  final Team? teamA;
  final Team? teamB;
  final _TeamSide teamSide;
  final bool canEdit;

  final TextEditingController pitchFeeController;
  final _FeeSplitMode feeSplitMode;
  final DateTime? meetTime;
  final bool bringCash;
  final bool bringBibs;
  final bool bringBall;
  final bool bringWater;
  final TextEditingController crewNotesController;
  final Map<int, Map<int, bool>> attendanceByTeamId;

  final bool matchLogisticsInitialized;
  final VoidCallback onMatchLogisticsInitialized;
  final VoidCallback onDirty;
  final ValueChanged<_TeamSide> onTeamSideChanged;
  final ValueChanged<_FeeSplitMode> onFeeSplitModeChanged;
  final ValueChanged<DateTime?> onMeetTimeChanged;
  final ValueChanged<bool> onBringCashChanged;
  final ValueChanged<bool> onBringBibsChanged;
  final ValueChanged<bool> onBringBallChanged;
  final ValueChanged<bool> onBringWaterChanged;
  final void Function(int teamId, int playerId, bool isComing)
  onAttendanceChanged;
  final VoidCallback onCopySummary;
  final VoidCallback onBack;

  @override
  State<_LogisticsTab> createState() => _LogisticsTabState();
}

class _LogisticsTabState extends State<_LogisticsTab> {
  late final TextEditingController _meetTimeController = TextEditingController(
    text: widget.meetTime == null ? '' : _formatTime(widget.meetTime!),
  );

  @override
  void dispose() {
    _meetTimeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _LogisticsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _meetTimeController.text = widget.meetTime == null
        ? ''
        : _formatTime(widget.meetTime!);
  }

  @override
  Widget build(BuildContext context) {
    final teamId = offeredTeamId(widget.match, teamSide: widget.teamSide);
    final effectiveTeamId = teamId ?? widget.match.teamAId;
    if (effectiveTeamId == null) return const SizedBox.shrink();

    final teamBDisabled = widget.match.teamBId == null;
    final kitColors = resolveKitColors(
      teamA: widget.teamA,
      teamB: widget.teamB,
      side: widget.teamSide,
    );

    final lineupProvider = context.read<LineupProvider>();
    final teamsProvider = context.read<TeamsProvider>();

    return StreamBuilder<List<Player>>(
      stream: teamsProvider.watchPlayersByTeam(effectiveTeamId),
      builder: (context, rosterSnapshot) {
        final roster = rosterSnapshot.data ?? const <Player>[];

        return StreamBuilder<List<AttendanceData>>(
          stream: lineupProvider.watchAttendance(
            widget.match.id,
            effectiveTeamId,
          ),
          builder: (context, attendanceSnapshot) {
            return StreamBuilder<MatchLogistic?>(
              stream: lineupProvider.watchMatchLogistics(widget.match.id),
              builder: (context, logisticsSnapshot) {
                _maybeInitFromDb(
                  context,
                  teamId: effectiveTeamId,
                  attendance: attendanceSnapshot.data,
                  attendanceState: attendanceSnapshot.connectionState,
                  logistics: logisticsSnapshot.data,
                  logisticsState: logisticsSnapshot.connectionState,
                );

                final attendanceByPlayerId =
                    widget.attendanceByTeamId[effectiveTeamId] ??
                    const <int, bool>{};
                final confirmedCount = roster
                    .where((p) => attendanceByPlayerId[p.id] == true)
                    .length;
                final totalCount = roster.length;
                final perPlayer = feePerPlayer(
                  total: parseFee(widget.pitchFeeController.text),
                  confirmedCount: confirmedCount,
                  rosterCount: totalCount,
                  mode: widget.feeSplitMode,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TeamSideSwitcher(
                      teamAName:
                          widget.teamA?.name ?? AppStrings.matchCenterTeamATbd,
                      teamBName:
                          widget.teamB?.name ?? AppStrings.matchCenterTeamBTbd,
                      teamSide: widget.teamSide,
                      teamBDisabled: teamBDisabled,
                      onChanged: (side) {
                        if (side == _TeamSide.b && teamBDisabled) return;
                        widget.onTeamSideChanged(side);
                      },
                    ),
                    if (teamBDisabled) ...[
                      Gaps.hSm,
                      Text(
                        AppStrings.lineupBoardTeamBNotAssigned,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteOverlay70,
                        ),
                      ),
                    ],
                    Gaps.hMd,
                    _SectionCard(
                      title: AppStrings.lineupBoardAttendanceTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.lineupBoardConfirmedCount(
                              confirmedCount,
                              totalCount,
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Gaps.hSm,
                          for (final player in roster) ...[
                            _AttendanceRow(
                              name: player.name,
                              position: normalizePosition(player.position),
                              kitColors: kitColors,
                              isComing:
                                  attendanceByPlayerId[player.id] ?? false,
                              enabled: widget.canEdit,
                              onChanged: (value) {
                                widget.onAttendanceChanged(
                                  effectiveTeamId,
                                  player.id,
                                  value,
                                );
                                widget.onDirty();
                              },
                            ),
                            if (player != roster.last)
                              const Divider(
                                height: 1,
                                color: AppColors.whiteOverlay20,
                              ),
                          ],
                        ],
                      ),
                    ),
                    Gaps.hMd,
                    _SectionCard(
                      title: AppStrings.lineupBoardFeeSplitTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.lineupBoardPitchFeeTotalLabel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: widget.pitchFeeController,
                            hintText: AppStrings.lineupBoardPitchFeeTotalHint,
                            suffixIconAsset: null,
                            keyboardType: TextInputType.number,
                            enabled: widget.canEdit,
                          ),
                          Gaps.hMd,
                          Row(
                            children: [
                              Expanded(
                                child: _RadioRow(
                                  label:
                                      AppStrings.lineupBoardSplitConfirmedOnly,
                                  selected:
                                      widget.feeSplitMode ==
                                      _FeeSplitMode.confirmedOnly,
                                  onTap: widget.canEdit
                                      ? () => widget.onFeeSplitModeChanged(
                                          _FeeSplitMode.confirmedOnly,
                                        )
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: _RadioRow(
                                  label: AppStrings.lineupBoardSplitAllRoster,
                                  selected:
                                      widget.feeSplitMode ==
                                      _FeeSplitMode.allRoster,
                                  onTap: widget.canEdit
                                      ? () => widget.onFeeSplitModeChanged(
                                          _FeeSplitMode.allRoster,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.lineupBoardPerPlayer(perPlayer),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Gaps.hXs,
                          Text(
                            AppStrings.lineupBoardFeeSplitHelperNote,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.whiteOverlay70),
                          ),
                        ],
                      ),
                    ),
                    Gaps.hMd,
                    _SectionCard(
                      title: AppStrings.lineupBoardMatchSheetNotesTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.lineupBoardMeetTimeLabel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _meetTimeController,
                            hintText: AppStrings.lineupBoardMeetTimeHint,
                            suffixIconAsset: AppIcons.calendar,
                            enabled: widget.canEdit,
                            readOnly: true,
                            onTap: widget.canEdit ? _pickMeetTime : null,
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.lineupBoardWhatToBringLabel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Gaps.hSm,
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              _ToggleChip(
                                label: AppStrings.lineupBoardBringCash,
                                selected: widget.bringCash,
                                onTap: widget.canEdit
                                    ? () => widget.onBringCashChanged(
                                        !widget.bringCash,
                                      )
                                    : null,
                              ),
                              _ToggleChip(
                                label: AppStrings.lineupBoardBringBibs,
                                selected: widget.bringBibs,
                                onTap: widget.canEdit
                                    ? () => widget.onBringBibsChanged(
                                        !widget.bringBibs,
                                      )
                                    : null,
                              ),
                              _ToggleChip(
                                label: AppStrings.lineupBoardBringBall,
                                selected: widget.bringBall,
                                onTap: widget.canEdit
                                    ? () => widget.onBringBallChanged(
                                        !widget.bringBall,
                                      )
                                    : null,
                              ),
                              _ToggleChip(
                                label: AppStrings.lineupBoardBringWater,
                                selected: widget.bringWater,
                                onTap: widget.canEdit
                                    ? () => widget.onBringWaterChanged(
                                        !widget.bringWater,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.lineupBoardCrewNotesLabel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Gaps.hSm,
                          AppTextAreaField(
                            controller: widget.crewNotesController,
                            hintText: AppStrings.lineupBoardCrewNotesHint,
                            enabled: widget.canEdit,
                          ),
                        ],
                      ),
                    ),
                    Gaps.hMd,
                    AppPrimaryButton(
                      label: AppStrings.lineupBoardCopySummary,
                      onPressed: widget.canEdit ? widget.onCopySummary : () {},
                    ),
                    Gaps.hSm,
                    AppDangerButton(
                      label: AppStrings.onboardingBack,
                      onPressed: widget.onBack,
                    ),
                    Gaps.hXl,
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _maybeInitFromDb(
    BuildContext context, {
    required int teamId,
    required List<AttendanceData>? attendance,
    required ConnectionState attendanceState,
    required MatchLogistic? logistics,
    required ConnectionState logisticsState,
  }) {
    if (attendanceState == ConnectionState.waiting) return;
    if (logisticsState == ConnectionState.waiting) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final root = context
          .findAncestorStateOfType<_LineupTacticsBoardPageState>();
      if (root == null || !root.mounted) return;

      final attendanceMap = <int, bool>{
        for (final row in attendance ?? const <AttendanceData>[])
          row.playerId: row.isComing,
      };

      root.setState(() {
        root._attendanceByTeamId.putIfAbsent(teamId, () => attendanceMap);
      });

      if (!widget.matchLogisticsInitialized) {
        root.setState(() {
          root._suppressDirty = true;
          root._pitchFeeController.text =
              logistics?.pitchFeeTotal?.toString() ?? '';
          root._feeSplitMode = (logistics?.splitMode ?? 'confirmed') == 'all'
              ? _FeeSplitMode.allRoster
              : _FeeSplitMode.confirmedOnly;
          root._meetTime = logistics?.meetTime;
          root._bringCash = logistics?.bringCash ?? false;
          root._bringBibs = logistics?.bringBibs ?? false;
          root._bringBall = logistics?.bringBall ?? false;
          root._bringWater = logistics?.bringWater ?? false;
          root._crewNotesController.text = logistics?.crewNotes ?? '';
          root._suppressDirty = false;
        });

        _meetTimeController.text = root._meetTime == null
            ? ''
            : _formatTime(root._meetTime!);
        widget.onMatchLogisticsInitialized();
      }
    });
  }

  Future<void> _pickMeetTime() async {
    final base = widget.match.startAt;
    final initial = widget.meetTime ?? base;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;

    final picked = DateTime(
      base.year,
      base.month,
      base.day,
      time.hour,
      time.minute,
    );

    _meetTimeController.text = _formatTime(picked);
    widget.onMeetTimeChanged(picked);
    widget.onDirty();
  }

  String _formatTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}

class _AttendanceRow extends StatelessWidget {
  const _AttendanceRow({
    required this.name,
    required this.position,
    required this.kitColors,
    required this.isComing,
    required this.enabled,
    required this.onChanged,
  });

  final String name;
  final String position;
  final _KitColors kitColors;
  final bool isComing;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.vMd,
      child: Row(
        children: [
          _TintedKitIcon(colors: kitColors, size: AppSizes.lineupSlotKitSize),
          Gaps.wSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  AppStrings.lineupBoardAttendancePos(position),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isComing,
            onChanged: enabled ? (v) => onChanged(v ?? false) : null,
            side: const BorderSide(color: AppColors.whiteOverlay20),
          ),
        ],
      ),
    );
  }
}

class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.pill,
      child: Row(
        children: [
          Container(
            height: AppSizes.matchCenterResultIndicatorSize,
            width: AppSizes.matchCenterResultIndicatorSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteOverlay20),
              color: selected ? AppColors.white : Colors.transparent,
            ),
            child: selected
                ? Center(
                    child: SvgPicture.asset(
                      AppIcons.check,
                      width: AppSizes.matchCenterResultIndicatorCheckSize,
                      height: AppSizes.matchCenterResultIndicatorCheckSize,
                      colorFilter: const ColorFilter.mode(
                        AppColors.darkNavy,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : Center(
                    child: SvgPicture.asset(
                      AppIcons.uncheck,
                      width: AppSizes.matchCenterResultIndicatorCheckSize,
                      height: AppSizes.matchCenterResultIndicatorCheckSize,
                      colorFilter: const ColorFilter.mode(
                        AppColors.darkNavy,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
          ),
          Gaps.wSm,
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.whiteOverlay70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onTap == null ? null : (_) => onTap!(),
      backgroundColor: AppColors.whiteOverlay10,
      selectedColor: AppColors.primaryBlue,
      checkmarkColor: AppColors.white,
      side: const BorderSide(color: AppColors.whiteOverlay20),
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.white,
      ),
    );
  }
}

class _TintedKitIcon extends StatelessWidget {
  const _TintedKitIcon({
    required this.colors,
    required this.size,
  });

  final _KitColors colors;
  final double size;

  static const String _primaryPlaceholder = '#FF0000';
  static const String _secondaryPlaceholder = '#0000FF';
  static Future<String>? _rawSvgFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _tintedSvg(colors),
      builder: (context, snapshot) {
        final svg = snapshot.data;
        if (svg == null) {
          return SizedBox(
            width: size,
            height: size,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: AppColors.whiteOverlay10),
            ),
          );
        }

        return SvgPicture.string(
          svg,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      },
    );
  }

  Future<String> _tintedSvg(_KitColors kit) async {
    final raw = await (_rawSvgFuture ??= rootBundle.loadString(
      AppImages.kitTemplateDefault,
    ));

    return raw
        .replaceAll(_primaryPlaceholder, _toHex(kit.primary))
        .replaceAll(_secondaryPlaceholder, _toHex(kit.secondary));
  }

  String _toHex(Color color) {
    final hex = color
        .toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2)
        .toUpperCase();
    return '#$hex';
  }
}
