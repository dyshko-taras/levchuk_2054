import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
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
import '../../data/models/team_directory_item.dart';
import '../../providers/fields_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/navigation/quick_bar.dart';
import 'field_form_page.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

enum _StatsTab { teams, matches, fields }

class _StatsPageState extends State<StatsPage> {
  _StatsTab _tab = _StatsTab.teams;
  int? _matchTeamFilterId;

  void _selectTab(_StatsTab tab) {
    setState(() {
      _tab = tab;
      if (tab != _StatsTab.matches) _matchTeamFilterId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final matches = context.watch<MatchesProvider>().matches;
    final fields = context.watch<FieldsProvider>().fields;

    final filteredMatches = _matchTeamFilterId == null
        ? matches
        : matches.where((m) => _matchHasTeam(m, _matchTeamFilterId!)).toList();

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
                      label: AppStrings.statsTitle,
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
                      label: AppStrings.statsTabTeams,
                      isSelected: _tab == _StatsTab.teams,
                      onPressed: () => _selectTab(_StatsTab.teams),
                    ),
                    QuickBarItem(
                      label: AppStrings.statsTabMatches,
                      isSelected: _tab == _StatsTab.matches,
                      onPressed: () => _selectTab(_StatsTab.matches),
                    ),
                    QuickBarItem(
                      label: AppStrings.statsTabFields,
                      isSelected: _tab == _StatsTab.fields,
                      onPressed: () => _selectTab(_StatsTab.fields),
                    ),
                  ],
                ),
                Gaps.hMd,
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSizes.statsTabContentMaxWidth,
                      ),
                      child: switch (_tab) {
                        _StatsTab.teams => _TeamsTab(
                          matches: matches,
                          onTeamTap: (teamId) => setState(() {
                            _matchTeamFilterId = teamId;
                            _tab = _StatsTab.matches;
                          }),
                        ),
                        _StatsTab.matches => _MatchesTab(
                          matches: filteredMatches,
                        ),
                        _StatsTab.fields => _FieldsTab(
                          matches: matches,
                          fields: fields,
                          onOpenField: (fieldId) =>
                              Navigator.of(context).pushNamed(
                                AppRoutes.fieldForm,
                                arguments: FieldFormArgs(fieldId: fieldId),
                              ),
                        ),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TeamsTab extends StatelessWidget {
  const _TeamsTab({required this.matches, required this.onTeamTap});

  final List<Fixture> matches;
  final ValueChanged<int> onTeamTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TeamDirectoryItem>>(
      stream: context.watch<TeamsProvider>().watchTeamsDirectory(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? const [];
        return _ListCard(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              _ListRow(
                leading: _CircleImage(path: items[i].team.badgeIcon),
                title: items[i].team.name,
                subtitle: _teamSubtitle(
                  teamId: items[i].team.id,
                  playersCount: items[i].playersCount,
                  matches: matches,
                ),
                onTap: () => onTeamTap(items[i].team.id),
              ),
              if (i != items.length - 1)
                const Divider(height: 1, color: AppColors.whiteOverlay20),
            ],
          ],
        );
      },
    );
  }

  String _teamSubtitle({
    required int teamId,
    required int playersCount,
    required List<Fixture> matches,
  }) {
    final finished = matches.where((m) => m.status == 'finished').toList();
    var wins = 0;
    var draws = 0;
    var losses = 0;

    for (final match in finished) {
      final isTeamA = match.teamAId == teamId;
      final isTeamB = match.teamBId == teamId;
      if (!isTeamA && !isTeamB) continue;

      switch (match.result) {
        case 'draw':
          draws++;
          break;
        case 'team_a':
          if (isTeamA) {
            wins++;
          } else if (isTeamB) {
            losses++;
          }
          break;
        case 'team_b':
          if (isTeamB) {
            wins++;
          } else if (isTeamA) {
            losses++;
          }
          break;
        default:
          break;
      }
    }

    final avgRoster = playersCount.toDouble();
    final wdl = '$wins/$draws/$losses';
    return '${AppStrings.statsTeamsPlayersPrefix} $playersCount  $wdl  ${AppStrings.statsTeamsAvgRosterLabel} ${avgRoster.toStringAsFixed(1)}';
  }
}

class _MatchesTab extends StatelessWidget {
  const _MatchesTab({required this.matches});

  final List<Fixture> matches;

  @override
  Widget build(BuildContext context) {
    final created = matches.length;
    final scheduled = matches.where((m) => m.status == 'planned').length;
    final finished = matches.where((m) => m.status == 'finished').length;

    final series = _buildMonthSeries(matches);

    final maxY = series.isEmpty
        ? 1.0
        : (series
                  .map((m) => (m.created + m.scheduled + m.finished).toDouble())
                  .reduce((a, b) => a > b ? a : b) +
              1);

    return Column(
      children: [
        _ListCard(
          children: [
            Padding(
              padding: Insets.allMd,
              child: Row(
                children: [
                  _SummaryMetric(
                    label: AppStrings.statsMatchesCreated,
                    value: created,
                    color: AppColors.statsCreated,
                  ),
                  const _MetricDivider(),
                  _SummaryMetric(
                    label: AppStrings.statsMatchesScheduled,
                    value: scheduled,
                    color: AppColors.statsScheduled,
                  ),
                  const _MetricDivider(),
                  _SummaryMetric(
                    label: AppStrings.statsMatchesFinished,
                    value: finished,
                    color: AppColors.statsFinished,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.whiteOverlay20),
            SizedBox(
              height: AppSizes.statsChartHeight,
              child: Padding(
                padding: Insets.allMd,
                child: BarChart(
                  BarChartData(
                    barTouchData: const BarTouchData(enabled: false),
                    titlesData: const FlTitlesData(show: false),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    maxY: maxY,
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: [
                      for (var i = 0; i < series.length; i++)
                        BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY:
                                  (series[i].created +
                                          series[i].scheduled +
                                          series[i].finished)
                                      .toDouble(),
                              width: AppSizes.statsChartBarWidth,
                              borderRadius: BorderRadius.circular(
                                AppSizes.statsChartBarRadius,
                              ),
                              rodStackItems: [
                                BarChartRodStackItem(
                                  0,
                                  series[i].finished.toDouble(),
                                  AppColors.statsFinished,
                                ),
                                BarChartRodStackItem(
                                  series[i].finished.toDouble(),
                                  (series[i].finished + series[i].scheduled)
                                      .toDouble(),
                                  AppColors.statsScheduled,
                                ),
                                BarChartRodStackItem(
                                  (series[i].finished + series[i].scheduled)
                                      .toDouble(),
                                  (series[i].finished +
                                          series[i].scheduled +
                                          series[i].created)
                                      .toDouble(),
                                  AppColors.statsCreated,
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<_MonthBucket> _buildMonthSeries(List<Fixture> matches) {
    final now = DateTime.now();
    final months = <DateTime>[
      for (var i = 7; i >= 0; i--) DateTime(now.year, now.month - i),
    ];

    return [
      for (final month in months)
        _MonthBucket(
          month: month,
          created: matches
              .where((m) => _isSameMonth(m.createdAt, month))
              .length,
          scheduled: matches
              .where(
                (m) => m.status == 'planned' && _isSameMonth(m.startAt, month),
              )
              .length,
          finished: matches
              .where(
                (m) => m.status == 'finished' && _isSameMonth(m.startAt, month),
              )
              .length,
        ),
    ];
  }
}

class _FieldsTab extends StatelessWidget {
  const _FieldsTab({
    required this.matches,
    required this.fields,
    required this.onOpenField,
  });

  final List<Fixture> matches;
  final List<Field> fields;
  final ValueChanged<int> onOpenField;

  @override
  Widget build(BuildContext context) {
    final items = [
      for (final field in fields)
        _FieldStatsItem(
          field: field,
          usageCount: matches.where((m) => m.fieldId == field.id).length,
          lastMatch: matches
              .where((m) => m.fieldId == field.id)
              .toList()
              .sortedByStartAtDesc
              .firstOrNull,
        ),
    ]..sort((a, b) => b.usageCount.compareTo(a.usageCount));

    return _ListCard(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _ListRow(
            leading: _CircleImage(
              path: items[i].field.photoPath ?? AppImages.fieldPhotoPlaceholder,
            ),
            title: items[i].field.name,
            subtitle: items[i].lastMatch == null
                ? '${AppStrings.statsFieldsUsagePrefix} ${items[i].usageCount}'
                : '${_formatDateTime(context, items[i].lastMatch!.startAt)} • ${AppStrings.statsFieldsUsagePrefix} ${items[i].usageCount}',
            onTap: () => onOpenField(items[i].field.id),
          ),
          if (i != items.length - 1)
            const Divider(height: 1, color: AppColors.whiteOverlay20),
        ],
      ],
    );
  }
}

class _FieldStatsItem {
  const _FieldStatsItem({
    required this.field,
    required this.usageCount,
    required this.lastMatch,
  });

  final Field field;
  final int usageCount;
  final Fixture? lastMatch;
}

class _MonthBucket {
  const _MonthBucket({
    required this.month,
    required this.created,
    required this.scheduled,
    required this.finished,
  });

  final DateTime month;
  final int created;
  final int scheduled;
  final int finished;
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: color),
          ),
          Gaps.hXs,
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteOverlay70,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricDivider extends StatelessWidget {
  const _MetricDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: AppSizes.statsMetricDividerWidth,
      height: AppSizes.statsMetricDividerHeight,
      child: ColoredBox(color: AppColors.whiteOverlay20),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Column(children: children),
    );
  }
}

class _ListRow extends StatelessWidget {
  const _ListRow({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: Insets.allSm,
        child: Row(
          children: [
            leading,
            Gaps.wSm,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Gaps.hXs,
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteOverlay70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Gaps.wSm,
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

class _CircleImage extends StatelessWidget {
  const _CircleImage({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    return SizedBox(
      width: AppSizes.matchCenterBadgeSize,
      height: AppSizes.matchCenterBadgeSize,
      child: path == null
          ? const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.whiteOverlay10,
                shape: BoxShape.circle,
              ),
            )
          : ClipOval(
              child: path.startsWith('assets/')
                  ? Image.asset(
                      path,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.whiteOverlay10,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : Image.file(
                      File(path),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.whiteOverlay10,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
            ),
    );
  }
}

bool _matchHasTeam(Fixture match, int teamId) =>
    match.teamAId == teamId || match.teamBId == teamId;

bool _isSameMonth(DateTime value, DateTime month) =>
    value.year == month.year && value.month == month.month;

String _formatDateTime(BuildContext context, DateTime value) {
  final date = MaterialLocalizations.of(context).formatMediumDate(value);
  final time = MaterialLocalizations.of(context).formatTimeOfDay(
    TimeOfDay.fromDateTime(value),
    alwaysUse24HourFormat: true,
  );
  return AppStrings.availabilityMatchCardTime(date, time);
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

extension on List<Fixture> {
  List<Fixture> get sortedByStartAtDesc {
    final list = [...this];
    list.sort((a, b) => b.startAt.compareTo(a.startAt));
    return list;
  }
}
