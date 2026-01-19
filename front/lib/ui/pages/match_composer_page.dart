import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/app_durations.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_limits.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_time_slots.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/teams_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_fields.dart';
import 'fields_registry_page.dart';

class MatchComposerPage extends StatefulWidget {
  const MatchComposerPage({super.key});

  @override
  State<MatchComposerPage> createState() => _MatchComposerPageState();
}

class _MatchComposerPageState extends State<MatchComposerPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _teamAController = TextEditingController();
  final TextEditingController _teamBController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  int? _editingMatchId;
  bool _editingEnabled = true;

  DateTime? _startAt;
  int? _fieldId;
  int? _teamAId;
  int? _teamBId;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initFromArgs());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateTimeController.dispose();
    _fieldController.dispose();
    _teamAController.dispose();
    _teamBController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _initFromArgs() {
    final args = ModalRoute.of(context)?.settings.arguments;
    final matchId = args is MatchComposerArgs ? args.matchId : null;
    final prefillStartAt = args is MatchComposerArgs
        ? args.prefillStartAt
        : null;
    final prefillFieldId = args is MatchComposerArgs
        ? args.prefillFieldId
        : null;
    final prefillTeamId = args is MatchComposerArgs ? args.prefillTeamId : null;

    final matchesProvider = context.read<MatchesProvider>();
    final settings = context.read<SettingsProvider>();

    if (matchId != null) {
      final match = matchesProvider.matches
          .where((m) => m.id == matchId)
          .firstOrNull;
      if (match != null) {
        _editingMatchId = match.id;
        _editingEnabled = false;
        _titleController.text = match.title;
        _startAt = match.startAt;
        _fieldId = match.fieldId;
        _teamAId = match.teamAId;
        _teamBId = match.teamBId;
        _notesController.text = match.notes ?? '';
      }
    } else {
      _editingEnabled = true;
      _startAt = prefillStartAt;
      _fieldId = prefillFieldId;
      _teamAId = prefillTeamId ?? settings.defaultTeamId;
    }

    _syncDisplayControllers();
    setState(() {});
  }

  void _syncDisplayControllers() {
    _dateTimeController.text = _startAt == null
        ? ''
        : _formatDateTime(context, _startAt!);

    final fields = context.read<FieldsProvider>().fields;
    _fieldController.text = _fieldId == null
        ? ''
        : _formatFieldLabel(
              fields.where((f) => f.id == _fieldId).firstOrNull,
            ) ??
            '';

    final teams = context.read<TeamsProvider>().teams;
    _teamAController.text = _teamAId == null
        ? ''
        : (teams.where((t) => t.id == _teamAId).firstOrNull?.name ?? '');
    _teamBController.text = _teamBId == null
        ? ''
        : (teams.where((t) => t.id == _teamBId).firstOrNull?.name ?? '');
  }

  Future<void> _pickDateTime() async {
    if (!_editingEnabled) return;

    final now = DateTime.now();
    final initial = _startAt ?? now;

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null) return;

    if (!mounted) return;
    final hour = await _pickHour(
      initialHour: (_startAt ?? initial).hour,
    );
    if (hour == null) return;

    final startAt = DateTime(
      date.year,
      date.month,
      date.day,
      hour == 24 ? 0 : hour,
      0,
    );
    setState(() => _startAt = startAt);
    _syncDisplayControllers();
  }

  Future<int?> _pickHour({required int initialHour}) async {
    final initial = AppTimeSlots.availabilityHours.contains(initialHour)
        ? initialHour
        : AppTimeSlots.availabilityHours.first;

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
                Padding(
                  padding: Insets.allMd,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.matchComposerDateTimeLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.whiteOverlay20),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: AppTimeSlots.availabilityHours.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: AppColors.whiteOverlay20,
                    ),
                    itemBuilder: (context, index) {
                      final hour = AppTimeSlots.availabilityHours[index];
                      final time = TimeOfDay(
                        hour: hour == 24 ? 0 : hour,
                        minute: 0,
                      );
                      final label = MaterialLocalizations.of(
                        context,
                      ).formatTimeOfDay(
                        time,
                        alwaysUse24HourFormat: true,
                      );

                      final selected = hour == initial;
                      return ListTile(
                        title: Text(
                          label,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: selected
                            ? const Icon(Icons.check, color: AppColors.white)
                            : null,
                        onTap: () => Navigator.of(context).pop(hour),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result;
  }

  Future<void> _pickFieldFromSheet() async {
    if (!_editingEnabled) return;
    final fields = context.read<FieldsProvider>().fields;
    final result = await _showPickerSheet<int>(
      title: AppStrings.matchComposerFieldLabel,
      items: [
        for (final field in fields)
          _PickerOption(
            label: _formatFieldLabel(field) ?? field.name,
            value: field.id,
          ),
      ],
    );
    if (result == null) return;
    setState(() => _fieldId = result);
    _syncDisplayControllers();
  }

  String? _formatFieldLabel(Field? field) {
    if (field == null) return null;
    final t = (field.type ?? '').trim();
    if (t.isEmpty) return field.name;
    return '${field.name} ($t)';
  }

  Future<void> _pickTeamA() async {
    if (!_editingEnabled) return;
    final teams = context.read<TeamsProvider>().teams;
    final excluded = _teamBId;
    final availableTeams = excluded == null
        ? teams
        : teams.where((t) => t.id != excluded).toList();
    final result = await _showPickerSheet<int>(
      title: AppStrings.matchComposerTeamALabel,
      items: [
        for (final team in availableTeams)
          _PickerOption(
            label: team.name,
            value: team.id,
          ),
      ],
    );
    if (result == null) return;
    setState(() => _teamAId = result);
    _syncDisplayControllers();
  }

  Future<void> _pickTeamB() async {
    if (!_editingEnabled) return;
    final teams = context.read<TeamsProvider>().teams;
    final excluded = _teamAId;
    final availableTeams = excluded == null
        ? teams
        : teams.where((t) => t.id != excluded).toList();
    if (availableTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.matchComposerErrorTeamBNoOptions)),
      );
      return;
    }

    final result = await _showPickerSheet<int>(
      title: AppStrings.matchComposerTeamBLabel,
      items: [
        for (final team in availableTeams)
          _PickerOption(
            label: team.name,
            value: team.id,
          ),
      ],
    );
    if (result == null) return;
    setState(() => _teamBId = result);
    _syncDisplayControllers();
  }

  Future<void> _pickFromFieldsRegistry() async {
    if (!_editingEnabled) return;
    final result = await Navigator.of(context).pushNamed(
      AppRoutes.fieldsRegistry,
      arguments: const FieldsRegistryArgs(selectForResult: true),
    );
    if (result is! int) return;
    setState(() => _fieldId = result);
    _syncDisplayControllers();
  }

  bool _hasTimeConflict({
    required DateTime startAt,
    required int? fieldId,
    required int? teamAId,
    required int? teamBId,
  }) {
    final matches = context.read<MatchesProvider>().matches;
    final thisMatchId = _editingMatchId;

    final aStart = startAt;
    final aEnd = aStart.add(
      AppDurations.matchDefault + AppDurations.matchBufferAfter,
    );

    for (final match in matches) {
      if (thisMatchId != null && match.id == thisMatchId) continue;

      final bStart = match.startAt;
      final bEnd = (match.endAt ?? bStart.add(AppDurations.matchDefault)).add(
        AppDurations.matchBufferAfter,
      );
      if (!_intervalsOverlap(aStart, aEnd, bStart, bEnd)) continue;

      final fieldConflict =
          fieldId != null && match.fieldId != null && fieldId == match.fieldId;
      final teamConflict = _sharesAnyTeam(match, teamAId, teamBId);

      if (fieldConflict || teamConflict) return true;
    }

    return false;
  }

  Future<void> _save() async {
    if (_saving || !_editingEnabled) return;

    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorTitleRequired),
        ),
      );
      return;
    }

    final startAt = _startAt;
    if (startAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorDateTimeRequired),
        ),
      );
      return;
    }

    final fieldId = _fieldId;
    if (fieldId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorFieldRequired),
        ),
      );
      return;
    }

    final teamAId = _teamAId;
    if (teamAId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorTeamARequired),
        ),
      );
      return;
    }

    final teamBId = _teamBId;
    if (teamBId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorTeamBRequired),
        ),
      );
      return;
    }

    if (teamBId == teamAId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.matchComposerErrorTeamsMustDiffer),
        ),
      );
      return;
    }

    final hasConflict = _hasTimeConflict(
      startAt: startAt,
      fieldId: fieldId,
      teamAId: teamAId,
      teamBId: teamBId,
    );
    if (hasConflict) {
      final proceed = await _confirmConflictSave();
      if (!proceed) return;
    }

    setState(() => _saving = true);
    final notes = _notesController.text.trim();
    final endAt = startAt.add(AppDurations.matchDefault);

    final provider = context.read<MatchesProvider>();
    final matchId = _editingMatchId;
    if (matchId == null) {
      await provider.createMatch(
        title: title,
        startAt: startAt,
        endAt: endAt,
        fieldId: fieldId,
        teamAId: teamAId,
        teamBId: teamBId,
        notes: notes.isEmpty ? null : notes,
      );
    } else {
      final existing = provider.matches
          .where((m) => m.id == matchId)
          .firstOrNull;
      if (existing != null) {
        await provider.updateMatch(
          existing.copyWith(
            title: title,
            startAt: startAt,
            endAt: Value(endAt),
            fieldId: Value(fieldId),
            teamAId: Value(teamAId),
            teamBId: Value(teamBId),
            notes: Value(notes.isEmpty ? null : notes),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    }

    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.of(context).pop();
  }

  Future<bool> _confirmConflictSave() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.darkNavy,
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
                  AppStrings.matchComposerConflictTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.hSm,
                Text(
                  AppStrings.matchComposerConflictMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
                Gaps.hMd,
                Row(
                  children: [
                    Expanded(
                      child: AppSecondaryButton(
                        label: AppStrings.matchComposerConflictAdjust,
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    Gaps.wSm,
                    Expanded(
                      child: AppPrimaryButton(
                        label: AppStrings.matchComposerConflictSaveAnyway,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  Future<void> _enableEditing() async {
    if (_editingMatchId == null) return;
    if (_editingEnabled) return;
    setState(() => _editingEnabled = true);
  }

  Future<void> _deleteMatch() async {
    final matchId = _editingMatchId;
    if (matchId == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.darkNavy,
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
                  AppStrings.matchComposerDeleteTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.hSm,
                Text(
                  AppStrings.matchComposerDeleteMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteOverlay70,
                  ),
                ),
                Gaps.hMd,
                Row(
                  children: [
                    Expanded(
                      child: AppSecondaryButton(
                        label: AppStrings.commonCancel,
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    Gaps.wSm,
                    Expanded(
                      child: AppDangerButton(
                        label: AppStrings.commonDelete,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirm != true) return;
    await context.read<MatchesProvider>().deleteMatchById(matchId);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final showEditActions = _editingMatchId != null;

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
                      label: AppStrings.matchComposerTitle,
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
                    if (showEditActions) ...[
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
                        onPressed: _enableEditing,
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
                        onPressed: _deleteMatch,
                      ),
                    ],
                  ],
                ),
                Gaps.hMd,
                Expanded(
                  child: SingleChildScrollView(
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
                          const _RequiredLabel(
                            label: AppStrings.matchComposerTitleLabel,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _titleController,
                            hintText: AppStrings.matchComposerTitleHint,
                            enabled: _editingEnabled,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                AppLimits.matchTitleMax,
                              ),
                            ],
                          ),
                          Gaps.hMd,
                          const _RequiredLabel(
                            label: AppStrings.matchComposerDateTimeLabel,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _dateTimeController,
                            hintText: AppStrings.matchComposerDateTimeHint,
                            enabled: _editingEnabled,
                            readOnly: true,
                            onTap: _pickDateTime,
                            suffixIconAsset: AppIcons.calendar,
                          ),
                          Gaps.hMd,
                          const _RequiredLabel(
                            label: AppStrings.matchComposerFieldLabel,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _fieldController,
                            hintText: AppStrings.matchComposerFieldHint,
                            enabled: _editingEnabled,
                            readOnly: true,
                            onTap: _pickFieldFromSheet,
                            suffixIconAsset: AppIcons.chevronDown,
                          ),
                          Gaps.hSm,
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: AppSizes.hubPillButtonHeight,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: _editingEnabled
                                    ? _pickFromFieldsRegistry
                                    : null,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.add,
                                      width: AppSizes.iconMd,
                                      height: AppSizes.iconMd,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Gaps.wSm,
                                    Text(
                                      AppStrings
                                          .matchComposerFieldPickFromFields,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Gaps.hMd,
                          Row(
                            children: [
                              Expanded(
                                child: _LabeledField(
                                  label: AppStrings.matchComposerTeamALabel,
                                  isRequired: true,
                                  child: AppPillTextField(
                                    controller: _teamAController,
                                    hintText: AppStrings.matchComposerTeamHint,
                                    enabled: _editingEnabled,
                                    readOnly: true,
                                    onTap: _pickTeamA,
                                  ),
                                ),
                              ),
                              Gaps.wSm,
                              Expanded(
                                child: _LabeledField(
                                  label: AppStrings.matchComposerTeamBLabel,
                                  isRequired: true,
                                  child: AppPillTextField(
                                    controller: _teamBController,
                                    hintText: AppStrings.matchComposerTeamHint,
                                    enabled: _editingEnabled,
                                    readOnly: true,
                                    onTap: _pickTeamB,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.matchComposerNotesLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Gaps.hSm,
                          AppTextAreaField(
                            controller: _notesController,
                            hintText: AppStrings.matchComposerNotesHint,
                            enabled: _editingEnabled,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                AppLimits.matchNotesMax,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.hMd,
                AppPrimaryButton(
                  label: AppStrings.matchComposerSave,
                  onPressed: _saving ? () {} : _save,
                ),
                Gaps.hSm,
                AppDangerButton(
                  label: AppStrings.matchComposerCancel,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<T?> _showPickerSheet<T>({
    required String title,
    required List<_PickerOption<T>> items,
  }) async {
    final result = await showModalBottomSheet<T>(
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
                Padding(
                  padding: Insets.allMd,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
    return result;
  }
}

class _PickerOption<T> {
  const _PickerOption({required this.label, required this.value});

  final String label;
  final T value;
}

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(text: label),
          const TextSpan(
            text: ' ${AppStrings.commonRequiredMarker}',
            style: TextStyle(color: AppColors.darkRed),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.isRequired,
    required this.child,
  });

  final String label;
  final bool isRequired;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired
            ? _RequiredLabel(label: label)
            : Text(label, style: Theme.of(context).textTheme.titleLarge),
        Gaps.hSm,
        child,
      ],
    );
  }
}

bool _intervalsOverlap(
  DateTime aStart,
  DateTime aEnd,
  DateTime bStart,
  DateTime bEnd,
) {
  return aStart.isBefore(bEnd) && bStart.isBefore(aEnd);
}

bool _sharesAnyTeam(Fixture match, int? teamAId, int? teamBId) {
  final matchTeams = <int>{
    if (match.teamAId != null) match.teamAId!,
    if (match.teamBId != null) match.teamBId!,
  };
  if (teamAId != null && matchTeams.contains(teamAId)) return true;
  if (teamBId != null && matchTeams.contains(teamBId)) return true;
  return false;
}

String _formatDateTime(BuildContext context, DateTime value) {
  final date = MaterialLocalizations.of(context).formatMediumDate(value);
  final time = MaterialLocalizations.of(context).formatTimeOfDay(
    TimeOfDay.fromDateTime(value),
    alwaysUse24HourFormat: true,
  );
  return '${AppStrings.availabilityMatchCardTime(date, time)}';
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class MatchComposerArgs {
  const MatchComposerArgs({
    this.matchId,
    this.prefillTeamId,
    this.prefillFieldId,
    this.prefillStartAt,
  });

  final int? matchId;
  final int? prefillTeamId;
  final int? prefillFieldId;
  final DateTime? prefillStartAt;
}
