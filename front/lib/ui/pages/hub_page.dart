import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../../utils/date_time_format.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/hub/hub_cards.dart';
import '../widgets/navigation/quick_bar.dart';
import 'field_form_page.dart';
import 'match_center_page.dart';
import 'lineup_tactics_board_page.dart';
import 'team_studio_page.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  _HubTab _tab = _HubTab.match;

  Future<void> _openSettings() async {
    await Navigator.of(context).pushNamed(AppRoutes.settings);
  }

  Future<void> _openTeamsDirectory() async {
    await Navigator.of(context).pushNamed(AppRoutes.teamsDirectory);
  }

  Future<void> _openMatchComposer() async {
    await Navigator.of(context).pushNamed(AppRoutes.matchComposer);
  }

  Future<void> _createTeam() async {
    await Navigator.of(context).pushNamed(
      AppRoutes.teamStudio,
      arguments: const TeamStudioArgs(createNew: true),
    );
  }

  Future<void> _createField() async {
    await Navigator.of(context).pushNamed(
      AppRoutes.fieldForm,
      arguments: const FieldFormArgs(createNew: true),
    );
  }

  Future<void> _openFieldsRegistry() async {
    await Navigator.of(context).pushNamed(AppRoutes.fieldsRegistry);
  }

  Future<void> _openLineupBoard() async {
    final matches = context.read<MatchesProvider>().matches;
    final nextMatch = _findNextMatch(matches);
    if (nextMatch == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.hubNoUpcomingMatch)));
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.lineupTactics,
      arguments: LineupTacticsArgs(matchId: nextMatch.id),
    );
  }

  Future<void> _openStats() async {
    await Navigator.of(context).pushNamed(AppRoutes.stats);
  }

  Future<void> _openAvailability() async {
    await Navigator.of(context).pushNamed(AppRoutes.availability);
  }

  @override
  Widget build(BuildContext context) {
    final matches = context.watch<MatchesProvider>().matches;
    final fields = context.watch<FieldsProvider>().fields;
    final teams = context.watch<TeamsProvider>().teams;
    final settings = context.watch<SettingsProvider>();
    final defaultTeamId = settings.defaultTeamId;
    final defaultFieldId = settings.defaultFieldId;

    final nextMatch = _findNextMatch(matches);
    final nextMatchDate = nextMatch == null
        ? null
        : formatDateTimeMmDd(nextMatch.startAt);
    final nextMatchFieldName = nextMatch?.fieldId == null
        ? null
        : fields
              .where((f) => f.id == nextMatch!.fieldId)
              .map((f) => f.name)
              .cast<String?>()
              .firstWhere((n) => n != null, orElse: () => null);

    final Team? defaultTeam = defaultTeamId == null
        ? null
        : teams.where((t) => t.id == defaultTeamId).firstOrNull;

    final Field? defaultField = defaultFieldId == null
        ? null
        : fields.where((f) => f.id == defaultFieldId).cast<Field?>().firstOrNull;

    final quickBarItems = <QuickBarItem>[
      QuickBarItem(
        label: AppStrings.hubTabMatch,
        isSelected: _tab == _HubTab.match,
        onPressed: () => setState(() => _tab = _HubTab.match),
      ),
      QuickBarItem(
        label: AppStrings.hubTabMySquad,
        isSelected: _tab == _HubTab.teams,
        onPressed: () => setState(() => _tab = _HubTab.teams),
      ),
      QuickBarItem(
        label: AppStrings.hubTabFields,
        isSelected: _tab == _HubTab.fields,
        onPressed: () => setState(() => _tab = _HubTab.fields),
      ),
      QuickBarItem(
        label: AppStrings.hubTabStats,
        isSelected: false,
        onPressed: _openStats,
      ),
      QuickBarItem(
        label: AppStrings.hubTabAvailability,
        isSelected: false,
        onPressed: _openAvailability,
      ),
    ];

    return Scaffold(
      floatingActionButton: SizedBox(
        height: AppSizes.hubFabSize,
        width: AppSizes.hubFabSize,
        child: FloatingActionButton(
          backgroundColor: AppColors.limeGreen,
          onPressed: switch (_tab) {
            _HubTab.match => _openMatchComposer,
            _HubTab.teams => _createTeam,
            _HubTab.fields => _createField,
          },
          child: SvgPicture.asset(
            AppIcons.add,
            colorFilter: const ColorFilter.mode(
              AppColors.darkNavy,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: Insets.allMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppStrings.hubAppTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  AppIconCircleButton(
                    icon: SvgPicture.asset(
                      AppIcons.settings,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: _openSettings,
                  ),
                ],
              ),
              Gaps.hMd,
              QuickBar(items: quickBarItems),
              Gaps.hLg,
              _SectionHeader(
                title: _tab == _HubTab.match
                    ? AppStrings.hubSectionNextMatch
                    : _tab == _HubTab.teams
                    ? AppStrings.hubSectionMySquad
                    : AppStrings.hubSectionFieldsSnapshot,
                actionLabel: _tab == _HubTab.teams
                    ? AppStrings.hubLinkAllTeams
                    : _tab == _HubTab.fields
                    ? AppStrings.hubLinkAllFields
                    : null,
                onAction: _tab == _HubTab.teams
                    ? _openTeamsDirectory
                    : _tab == _HubTab.fields
                    ? _openFieldsRegistry
                    : null,
              ),
              Gaps.hSm,
              Expanded(
                child: _HubBody(
                  tab: _tab,
                  nextMatchDate: nextMatchDate,
                  nextMatchFieldName: nextMatchFieldName,
                  nextMatchStatusLabel: nextMatch == null
                      ? null
                      : (nextMatch.status == 'finished'
                            ? AppStrings.availabilityStatusFinished
                            : AppStrings.availabilityMatchPlanned),
                  nextMatchIsFinished: nextMatch?.status == 'finished',
                  onOpenNextMatch: () {
                    if (nextMatch == null) return;
                    Navigator.of(context).pushNamed(
                      AppRoutes.matchCenter,
                      arguments: MatchCenterArgs(matchId: nextMatch.id),
                    );
                  },
                  onAddMatch: _openMatchComposer,
                  defaultTeam: defaultTeam,
                  onOpenTeam: (teamId) => Navigator.of(context).pushNamed(
                    AppRoutes.teamStudio,
                    arguments: TeamStudioArgs(teamId: teamId),
                  ),
                  onCreateTeam: _createTeam,
                  onOpenLineup: _openLineupBoard,
                  defaultField: defaultField,
                  onOpenField: (fieldId) => Navigator.of(context).pushNamed(
                    AppRoutes.fieldForm,
                    arguments: FieldFormArgs(fieldId: fieldId),
                  ),
                  onCreateField: _createField,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Fixture? _findNextMatch(List<Fixture> matches) {
    if (matches.isEmpty) return null;
    final now = DateTime.now();
    final upcoming = matches.where((m) => m.startAt.isAfter(now)).toList();
    upcoming.sort((a, b) => a.startAt.compareTo(b.startAt));
    return upcoming.isEmpty ? null : upcoming.first;
  }
}

enum _HubTab { match, teams, fields }

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        if (actionLabel != null && onAction != null)
          InkWell(
            onTap: onAction,
            child: Row(
              children: [
                Text(
                  actionLabel!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
                Gaps.wXs,
                SvgPicture.asset(
                  AppIcons.chevronRight,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteOverlay70,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _HubBody extends StatelessWidget {
  const _HubBody({
    required this.tab,
    required this.nextMatchDate,
    required this.nextMatchFieldName,
    required this.nextMatchStatusLabel,
    required this.nextMatchIsFinished,
    required this.onOpenNextMatch,
    required this.onAddMatch,
    required this.defaultTeam,
    required this.onOpenTeam,
    required this.onCreateTeam,
    required this.onOpenLineup,
    required this.defaultField,
    required this.onOpenField,
    required this.onCreateField,
  });

  final _HubTab tab;

  final String? nextMatchDate;
  final String? nextMatchFieldName;
  final String? nextMatchStatusLabel;
  final bool? nextMatchIsFinished;
  final VoidCallback onOpenNextMatch;
  final VoidCallback onAddMatch;

  final Team? defaultTeam;
  final ValueChanged<int> onOpenTeam;
  final VoidCallback onCreateTeam;
  final VoidCallback onOpenLineup;

  final Field? defaultField;
  final ValueChanged<int> onOpenField;
  final VoidCallback onCreateField;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppSizes.hubContentMaxWidth,
        ),
        child: switch (tab) {
          _HubTab.match => SizedBox(
            height: AppSizes.hubCardHeight,
            child: NextMatchCard(
              matchDateTime: nextMatchDate,
              matchFieldName: nextMatchFieldName,
              statusLabel: nextMatchStatusLabel,
              isFinished: nextMatchIsFinished ?? false,
              onOpen: onOpenNextMatch,
              onAddMatch: onAddMatch,
            ),
          ),
          _HubTab.teams => SizedBox(
            height: AppSizes.hubCardHeight,
            child: defaultTeam == null
                ? DefaultTeamCard(
                    teamName: null,
                    playersCount: null,
                    onOpen: onCreateTeam,
                    onLineup: onOpenLineup,
                  )
                : StreamBuilder<List<Player>>(
                    stream: context
                        .read<TeamsProvider>()
                        .watchPlayersByTeam(defaultTeam!.id),
                    builder: (context, snapshot) {
                      return DefaultTeamCard(
                        teamName: defaultTeam!.name,
                        playersCount: snapshot.data?.length ?? 0,
                        onOpen: () => onOpenTeam(defaultTeam!.id),
                        onLineup: onOpenLineup,
                      );
                    },
                  ),
          ),
          _HubTab.fields => SizedBox(
            height: AppSizes.hubCardHeight,
            child: DefaultFieldCard(
              fieldName: defaultField?.name,
              fieldSubtitle: defaultField?.address,
              onOpen: defaultField == null
                  ? onCreateField
                  : () => onOpenField(defaultField!.id),
            ),
          ),
        },
      ),
    );
  }
}

extension on Iterable<Team> {
  Team? get firstOrNull => isEmpty ? null : first;
}
