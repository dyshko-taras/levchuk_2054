import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/settings_entries.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [SettingsEntries])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<List<SettingsEntry>> watchAll() => select(settingsEntries).watch();

  Future<void> upsert(SettingsEntriesCompanion entry) =>
      into(settingsEntries).insertOnConflictUpdate(entry);
}
