import 'package:shared_preferences/shared_preferences.dart';

class PrefsStore {
  const PrefsStore(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyFirstLaunchCompleted = 'first_launch_completed';
  static const String _keyLocalRemindersEnabled = 'local_reminders_enabled';
  static const String _keyDefaultTeamId = 'default_team_id';

  static Future<PrefsStore> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefsStore(prefs);
  }

  bool get isFirstLaunch => !_prefs.getBool(_keyFirstLaunchCompleted).isTrue;

  Future<void> setFirstLaunchCompleted() =>
      _prefs.setBool(_keyFirstLaunchCompleted, true);

  bool get localRemindersEnabled =>
      _prefs.getBool(_keyLocalRemindersEnabled) ?? true;

  Future<void> setLocalRemindersEnabled(bool value) =>
      _prefs.setBool(_keyLocalRemindersEnabled, value);

  int? get defaultTeamId => _prefs.getInt(_keyDefaultTeamId);

  Future<void> setDefaultTeamId(int? teamId) async {
    if (teamId == null) {
      await _prefs.remove(_keyDefaultTeamId);
      return;
    }

    await _prefs.setInt(_keyDefaultTeamId, teamId);
  }

  Future<void> clear() => _prefs.clear();
}

extension on bool? {
  bool get isTrue => this == true;
}
