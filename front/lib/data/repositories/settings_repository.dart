import '../local/database/app_database.dart';
import '../local/prefs_store.dart';

class SettingsRepository {
  const SettingsRepository({
    required AppDatabase database,
    required PrefsStore prefs,
  }) : _database = database,
       _prefs = prefs;

  final AppDatabase _database;
  final PrefsStore _prefs;

  PrefsStore get prefs => _prefs;

  Future<void> clearAllData() async {
    await _database.close();
    await _prefs.clear();
  }
}
