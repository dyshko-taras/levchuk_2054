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
    await _database.transaction(() async {
      await _database.delete(_database.attendance).go();
      await _database.delete(_database.lineupSlots).go();
      await _database.delete(_database.lineups).go();
      await _database.delete(_database.matches).go();
      await _database.delete(_database.fields).go();
      await _database.delete(_database.players).go();
      await _database.delete(_database.teams).go();
      await _database.delete(_database.doDontItems).go();
      await _database.delete(_database.tactics).go();
      await _database.delete(_database.settingsEntries).go();
    });
    await _prefs.clear();
  }
}
