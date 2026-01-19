import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/app_durations.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/navigation/quick_bar.dart';
import 'match_center_page.dart';
import 'match_composer_page.dart';

class AvailabilityGridPage extends StatefulWidget {
  const AvailabilityGridPage({super.key});

  @override
  State<AvailabilityGridPage> createState() => _AvailabilityGridPageState();
}

enum _PeriodFilter { week, month }

enum _TeamFilter { defaultTeam, anyTeam }

enum _SlotStatus { free, occupied, conflict }

class _AvailabilityGridPageState extends State<AvailabilityGridPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  _PeriodFilter _period = _PeriodFilter.month;
  _TeamFilter _teamFilter = _TeamFilter.defaultTeam;
  int? _fieldFilterId;

  PageController? _calendarPageController;

  @override
  Widget build(BuildContext context) {
    final teams = context.watch<TeamsProvider>().teams;
    final fields = context.watch<FieldsProvider>().fields;
    final matches = context.watch<MatchesProvider>().matches;
    final settings = context.watch<SettingsProvider>();

    final filteredMatches = _filterMatches(
      matches: matches,
      defaultTeamId: settings.defaultTeamId,
      teamFilter: _teamFilter,
      fieldFilterId: _fieldFilterId,
    );

    final dayMatches =
        filteredMatches
            .where((m) => _isSameDate(m.startAt, _selectedDay))
            .toList()
          ..sort((a, b) => a.startAt.compareTo(b.startAt));

    final slotStatuses = _buildSlotStatuses(dayMatches);
    final hasConflicts = slotStatuses.values.any(
      (status) => status == _SlotStatus.conflict,
    );

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
                      label: AppStrings.availabilityTitle,
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
                      label: AppStrings.availabilityFilterPeriod,
                      isSelected: true,
                      onPressed: _openPeriodPicker,
                      trailing: _chevronDownIcon(),
                    ),
                    QuickBarItem(
                      label: AppStrings.availabilityFilterTeam,
                      isSelected: false,
                      onPressed: () => _openTeamPicker(
                        defaultTeamId: settings.defaultTeamId,
                      ),
                      trailing: _chevronDownIcon(),
                    ),
                    QuickBarItem(
                      label: AppStrings.availabilityFilterField,
                      isSelected: false,
                      onPressed: () => _openFieldPicker(fields: fields),
                      trailing: _chevronDownIcon(),
                    ),
                  ],
                ),
                if (hasConflicts) ...[
                  Gaps.hSm,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: AppSizes.hubPillButtonHeight,
                      child: AppPillButton(
                        label: AppStrings.availabilityResolveConflicts,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                AppStrings.availabilityResolveConflicts,
                              ),
                            ),
                          );
                        },
                        backgroundColor: AppColors.whiteOverlay10,
                      ),
                    ),
                  ),
                ],
                Gaps.hMd,
                _CalendarCard(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  period: _period,
                  onCalendarCreated: (controller) =>
                      _calendarPageController = controller,
                  onPrev: _prevCalendarPage,
                  onNext: _nextCalendarPage,
                  hasMatchOnDay: (day) => filteredMatches.any(
                    (m) => _isSameDate(m.startAt, day),
                  ),
                  onDaySelected: (day, focused) => setState(() {
                    _selectedDay = day;
                    _focusedDay = focused;
                  }),
                  onPageChanged: (focused) =>
                      setState(() => _focusedDay = focused),
                ),
                Gaps.hMd,
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _DaySlotsCard(
                        day: _selectedDay,
                        slotStatuses: slotStatuses,
                        matches: dayMatches,
                        onCreateAt: (startAt) =>
                            Navigator.of(context).pushNamed(
                              AppRoutes.matchComposer,
                              arguments: MatchComposerArgs(
                                prefillStartAt: startAt,
                              ),
                            ),
                        onOpenMatch: (matchId) =>
                            Navigator.of(context).pushNamed(
                              AppRoutes.matchCenter,
                              arguments: MatchCenterArgs(matchId: matchId),
                            ),
                      ),
                      Gaps.hMd,
                      _SelectedMatchCard(
                        selectedDay: _selectedDay,
                        matches: dayMatches,
                        teams: teams,
                        fields: fields,
                        onOpen: (matchId) => Navigator.of(context).pushNamed(
                          AppRoutes.matchCenter,
                          arguments: MatchCenterArgs(matchId: matchId),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chevronDownIcon() {
    return SvgPicture.asset(
      AppIcons.chevronDown,
      width: AppSizes.iconMd,
      height: AppSizes.iconMd,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    );
  }

  void _prevCalendarPage() {
    final controller = _calendarPageController;
    if (controller == null || !controller.hasClients) return;
    controller.previousPage(
      duration: AppDurations.slow,
      curve: Curves.easeInOut,
    );
  }

  void _nextCalendarPage() {
    final controller = _calendarPageController;
    if (controller == null || !controller.hasClients) return;
    controller.nextPage(duration: AppDurations.slow, curve: Curves.easeInOut);
  }

  Future<void> _openPeriodPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: _PickerSheet(
            items: [
              _PickerItem(
                label: AppStrings.availabilityPeriodWeek,
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() => _period = _PeriodFilter.week);
                },
              ),
              _PickerItem(
                label: AppStrings.availabilityPeriodMonth,
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() => _period = _PeriodFilter.month);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openTeamPicker({required int? defaultTeamId}) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: _PickerSheet(
            items: [
              _PickerItem(
                label: AppStrings.availabilityTeamDefault,
                onTap: () {
                  Navigator.of(context).pop();
                  if (defaultTeamId == null) {
                    setState(() => _teamFilter = _TeamFilter.anyTeam);
                    return;
                  }
                  setState(() => _teamFilter = _TeamFilter.defaultTeam);
                },
              ),
              _PickerItem(
                label: AppStrings.availabilityTeamAny,
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() => _teamFilter = _TeamFilter.anyTeam);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openFieldPicker({required List<Field> fields}) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: _PickerSheet(
            items: [
              _PickerItem(
                label: AppStrings.availabilityFieldAll,
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() => _fieldFilterId = null);
                },
              ),
              for (final field in fields)
                _PickerItem(
                  label: field.name,
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() => _fieldFilterId = field.id);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _PickerItem {
  const _PickerItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.items});

  final List<_PickerItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.whiteOverlay20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items) ...[
            ListTile(
              title: Text(
                item.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: item.onTap,
            ),
            if (item != items.last)
              const Divider(height: 1, color: AppColors.whiteOverlay20),
          ],
        ],
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({
    required this.focusedDay,
    required this.selectedDay,
    required this.period,
    required this.onCalendarCreated,
    required this.onPrev,
    required this.onNext,
    required this.hasMatchOnDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final _PeriodFilter period;
  final ValueChanged<PageController> onCalendarCreated;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final bool Function(DateTime day) hasMatchOnDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

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
        children: [
          Row(
            children: [
              Text(
                MaterialLocalizations.of(context).formatMonthYear(focusedDay),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              AppIconCircleButton(
                icon: SvgPicture.asset(
                  AppIcons.chevronLeft,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: onPrev,
              ),
              Gaps.wSm,
              AppIconCircleButton(
                icon: SvgPicture.asset(
                  AppIcons.chevronRight,
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: onNext,
              ),
            ],
          ),
          Gaps.hSm,
          TableCalendar<void>(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2035),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableCalendarFormats: const {
              CalendarFormat.week: '',
              CalendarFormat.month: '',
            },
            calendarFormat: period == _PeriodFilter.week
                ? CalendarFormat.week
                : CalendarFormat.month,
            headerVisible: false,
            onCalendarCreated: onCalendarCreated,
            rowHeight: AppSizes.availabilityCalendarDayRowHeight,
            daysOfWeekHeight: AppSizes.availabilityCalendarDaysOfWeekHeight,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
              weekendTextStyle: Theme.of(context).textTheme.bodyMedium!,
              outsideTextStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.whiteOverlay70),
              todayDecoration: const BoxDecoration(
                color: AppColors.whiteOverlay20,
                borderRadius: AppRadius.md,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.whiteOverlay20),
                ),
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: AppRadius.md,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.whiteOverlay20),
                ),
              ),
              defaultDecoration: const BoxDecoration(
                color: AppColors.whiteOverlay20,
                borderRadius: AppRadius.md,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.whiteOverlay20),
                ),
              ),
              weekendDecoration: const BoxDecoration(
                color: AppColors.whiteOverlay20,
                borderRadius: AppRadius.md,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.whiteOverlay20),
                ),
              ),
              outsideDecoration: const BoxDecoration(
                color: AppColors.darkNavy,
                borderRadius: AppRadius.md,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.whiteOverlay20),
                ),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.whiteOverlay70),
              weekendStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.whiteOverlay70),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (!hasMatchOnDay(day)) return null;
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: AppSizes.availabilityCalendarMarkerSize,
                    height: AppSizes.availabilityCalendarMarkerSize,
                    margin: const EdgeInsets.only(
                      bottom: AppSizes.availabilityCalendarMarkerBottomMargin,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.limeGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
          ),
        ],
      ),
    );
  }
}

class _DaySlotsCard extends StatelessWidget {
  const _DaySlotsCard({
    required this.day,
    required this.slotStatuses,
    required this.matches,
    required this.onCreateAt,
    required this.onOpenMatch,
  });

  final DateTime day;
  final Map<int, _SlotStatus> slotStatuses;
  final List<Fixture> matches;
  final ValueChanged<DateTime> onCreateAt;
  final ValueChanged<int> onOpenMatch;

  @override
  Widget build(BuildContext context) {
    final title = MaterialLocalizations.of(context).formatMediumDate(day);
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
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Divider(height: 20, color: AppColors.whiteOverlay20),
          _SlotsSection(
            label: AppStrings.availabilityDayMorning,
            hours: const [6, 7, 8, 9, 10, 11],
            day: day,
            slotStatuses: slotStatuses,
            matches: matches,
            onCreateAt: onCreateAt,
            onOpenMatch: onOpenMatch,
          ),
          const Divider(height: 20, color: AppColors.whiteOverlay20),
          _SlotsSection(
            label: AppStrings.availabilityDayAfternoon,
            hours: const [12, 13, 14, 15, 16, 17, 18],
            day: day,
            slotStatuses: slotStatuses,
            matches: matches,
            onCreateAt: onCreateAt,
            onOpenMatch: onOpenMatch,
          ),
          const Divider(height: 20, color: AppColors.whiteOverlay20),
          _SlotsSection(
            label: AppStrings.availabilityDayEvening,
            hours: const [19, 20, 21, 22, 23, 24],
            day: day,
            slotStatuses: slotStatuses,
            matches: matches,
            onCreateAt: onCreateAt,
            onOpenMatch: onOpenMatch,
          ),
        ],
      ),
    );
  }
}

class _SlotsSection extends StatelessWidget {
  const _SlotsSection({
    required this.label,
    required this.hours,
    required this.day,
    required this.slotStatuses,
    required this.matches,
    required this.onCreateAt,
    required this.onOpenMatch,
  });

  final String label;
  final List<int> hours;
  final DateTime day;
  final Map<int, _SlotStatus> slotStatuses;
  final List<Fixture> matches;
  final ValueChanged<DateTime> onCreateAt;
  final ValueChanged<int> onOpenMatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        Gaps.hSm,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final hour in hours)
              _TimeSlotChip(
                day: day,
                hour: hour,
                status: slotStatuses[hour] ?? _SlotStatus.free,
                match: _findFirstMatchForHour(matches, day: day, hour: hour),
                onCreateAt: onCreateAt,
                onOpenMatch: onOpenMatch,
              ),
          ],
        ),
      ],
    );
  }
}

class _TimeSlotChip extends StatelessWidget {
  const _TimeSlotChip({
    required this.day,
    required this.hour,
    required this.status,
    required this.match,
    required this.onCreateAt,
    required this.onOpenMatch,
  });

  final DateTime day;
  final int hour;
  final _SlotStatus status;
  final Fixture? match;
  final ValueChanged<DateTime> onCreateAt;
  final ValueChanged<int> onOpenMatch;

  @override
  Widget build(BuildContext context) {
    final timeText = _formatHour(context, hour);

    final backgroundColor = switch (status) {
      _SlotStatus.free => AppColors.limeGreen.withValues(alpha: 0.30),
      _SlotStatus.occupied => AppColors.whiteOverlay20,
      _SlotStatus.conflict => AppColors.darkRed.withValues(alpha: 0.45),
    };

    return SizedBox(
      height: AppSizes.availabilityTimeChipHeight,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        onPressed: match == null
            ? () => onCreateAt(_startAtFor(day, hour))
            : () => onOpenMatch(match!.id),
        child: Text(
          timeText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SelectedMatchCard extends StatelessWidget {
  const _SelectedMatchCard({
    required this.selectedDay,
    required this.matches,
    required this.teams,
    required this.fields,
    required this.onOpen,
  });

  final DateTime selectedDay;
  final List<Fixture> matches;
  final List<Team> teams;
  final List<Field> fields;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final match = matches.isEmpty ? null : matches.first;
    if (match == null) return const SizedBox.shrink();

    final title = AppStrings.availabilityMatchCardTime(
      MaterialLocalizations.of(context).formatMediumDate(selectedDay),
      MaterialLocalizations.of(context).formatTimeOfDay(
        TimeOfDay.fromDateTime(match.startAt),
        alwaysUse24HourFormat: true,
      ),
    );

    final teamAText =
        _teamName(teams, match.teamAId) ?? AppStrings.commonPlaceholderDash;
    final teamBText =
        _teamName(teams, match.teamBId) ?? AppStrings.commonPlaceholderDash;
    final teamsText = AppStrings.availabilityMatchCardTeams(
      teamAText,
      teamBText,
    );
    final fieldText =
        _fieldName(fields, match.fieldId) ?? AppStrings.commonPlaceholderDash;

    final isFinished = match.status == 'finished';
    final statusLabel = isFinished
        ? AppStrings.availabilityStatusFinished
        : AppStrings.availabilityMatchPlanned;

    return SizedBox(
      height: AppSizes.availabilityMatchCardHeight,
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        onTap: () => onOpen(match.id),
        child: Container(
          padding: Insets.allMd,
          decoration: BoxDecoration(
            color: AppColors.whiteOverlay10,
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            border: Border.all(color: AppColors.whiteOverlay20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teamsText,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.hXs,
                        Text(
                          fieldText,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.whiteOverlay70,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSizes.hubStatusChipHeight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteOverlay10,
                      borderRadius: AppRadius.pill,
                      border: Border.all(
                        color:
                            isFinished
                                ? AppColors.statsScheduled
                                : AppColors.limeGreen,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: AppSizes.hubStatusDotSize,
                          width: AppSizes.hubStatusDotSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                        ),
                        Gaps.wSm,
                        Text(
                          statusLabel,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Fixture> _filterMatches({
  required List<Fixture> matches,
  required int? defaultTeamId,
  required _TeamFilter teamFilter,
  required int? fieldFilterId,
}) {
  final byField = fieldFilterId == null
      ? matches
      : matches.where((m) => m.fieldId == fieldFilterId).toList();

  if (teamFilter == _TeamFilter.anyTeam) return byField;
  if (defaultTeamId == null) return byField;

  return byField.where((m) => _matchHasTeam(m, defaultTeamId)).toList();
}

Map<int, _SlotStatus> _buildSlotStatuses(List<Fixture> matches) {
  final statuses = <int, _SlotStatus>{};
  for (final hour in const [
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
  ]) {
    final overlapping = matches.where((m) => _overlapsHour(m, hour)).toList();
    if (overlapping.isEmpty) {
      statuses[hour] = _SlotStatus.free;
      continue;
    }

    statuses[hour] = _hasConflict(overlapping)
        ? _SlotStatus.conflict
        : _SlotStatus.occupied;
  }
  return statuses;
}

bool _hasConflict(List<Fixture> overlapping) {
  for (var i = 0; i < overlapping.length; i++) {
    for (var j = i + 1; j < overlapping.length; j++) {
      final a = overlapping[i];
      final b = overlapping[j];

      if (a.fieldId != null && a.fieldId == b.fieldId) return true;

      final teamsA = _teamsInMatch(a);
      final teamsB = _teamsInMatch(b);
      if (teamsA.any(teamsB.contains)) return true;
    }
  }
  return false;
}

Set<int> _teamsInMatch(Fixture m) {
  final out = <int>{};
  if (m.teamAId != null) out.add(m.teamAId!);
  if (m.teamBId != null) out.add(m.teamBId!);
  return out;
}

bool _matchHasTeam(Fixture m, int teamId) =>
    m.teamAId == teamId || m.teamBId == teamId;

bool _overlapsHour(Fixture match, int hour) {
  final day = match.startAt;
  final slotStart = _startAtFor(day, hour);
  final slotEnd = slotStart.add(AppDurations.availabilitySlot);

  final matchEnd =
      (match.endAt ?? match.startAt.add(AppDurations.matchDefault)).add(
        AppDurations.matchBufferAfter,
      );
  return _intervalsOverlap(slotStart, slotEnd, match.startAt, matchEnd);
}

bool _intervalsOverlap(
  DateTime aStart,
  DateTime aEnd,
  DateTime bStart,
  DateTime bEnd,
) {
  return aStart.isBefore(bEnd) && bStart.isBefore(aEnd);
}

Fixture? _findFirstMatchForHour(
  List<Fixture> matches, {
  required DateTime day,
  required int hour,
}) {
  final slotStart = _startAtFor(day, hour);
  final slotEnd = slotStart.add(AppDurations.availabilitySlot);

  final overlapping = matches.where((m) {
    final matchEnd =
        (m.endAt ?? m.startAt.add(AppDurations.matchDefault)).add(
          AppDurations.matchBufferAfter,
        );
    return _intervalsOverlap(slotStart, slotEnd, m.startAt, matchEnd);
  }).toList()..sort((a, b) => a.startAt.compareTo(b.startAt));

  return overlapping.isEmpty ? null : overlapping.first;
}

DateTime _startAtFor(DateTime day, int hour) {
  return DateTime(
    day.year,
    day.month,
    day.day,
    hour == 24 ? 0 : hour,
    0,
  );
}

String _formatHour(BuildContext context, int hour) {
  final time = TimeOfDay(hour: hour == 24 ? 0 : hour, minute: 0);
  return MaterialLocalizations.of(context).formatTimeOfDay(
    time,
    alwaysUse24HourFormat: true,
  );
}

bool _isSameDate(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String? _teamName(List<Team> teams, int? teamId) {
  if (teamId == null) return null;
  for (final t in teams) {
    if (t.id == teamId) return t.name;
  }
  return null;
}

String? _fieldName(List<Field> fields, int? fieldId) {
  if (fieldId == null) return null;
  for (final f in fields) {
    if (f.id == fieldId) return f.name;
  }
  return null;
}
