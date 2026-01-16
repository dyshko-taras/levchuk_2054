import 'package:flutter/foundation.dart';

import '../data/repositories/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({required SettingsRepository repository})
    : _repository = repository;

  final SettingsRepository _repository;

  bool get isFirstLaunch => _repository.prefs.isFirstLaunch;

  bool get localRemindersEnabled => _repository.prefs.localRemindersEnabled;

  int? get defaultTeamId => _repository.prefs.defaultTeamId;

  Future<void> setFirstLaunchCompleted() async {
    await _repository.prefs.setFirstLaunchCompleted();
    notifyListeners();
  }

  Future<void> setLocalRemindersEnabled(bool value) async {
    await _repository.prefs.setLocalRemindersEnabled(value);
    notifyListeners();
  }

  Future<void> setDefaultTeamId(int? teamId) async {
    await _repository.prefs.setDefaultTeamId(teamId);
    notifyListeners();
  }

  Future<void> clearAllData() async {
    await _repository.clearAllData();
    notifyListeners();
  }
}
