import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'dao/fields_dao.dart';
import 'dao/lineup_dao.dart';
import 'dao/matches_dao.dart';
import 'dao/settings_dao.dart';
import 'dao/tactics_dao.dart';
import 'dao/teams_dao.dart';
import 'schema/attendance.dart';
import 'schema/do_dont_items.dart';
import 'schema/fields.dart';
import 'schema/lineup_slots.dart';
import 'schema/lineups.dart';
import 'schema/matches.dart';
import 'schema/players.dart';
import 'schema/settings_entries.dart';
import 'schema/tactics.dart';
import 'schema/teams.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/field_captain.sqlite');
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Teams,
    Players,
    Fields,
    Matches,
    Lineups,
    LineupSlots,
    Attendance,
    Tactics,
    DoDontItems,
    SettingsEntries,
  ],
  daos: [
    TeamsDao,
    FieldsDao,
    MatchesDao,
    LineupDao,
    TacticsDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {
      await m.drop(settingsEntries);
      await m.drop(doDontItems);
      await m.drop(tactics);
      await m.drop(attendance);
      await m.drop(lineupSlots);
      await m.drop(lineups);
      await m.drop(matches);
      await m.drop(fields);
      await m.drop(players);
      await m.drop(teams);
      await m.createAll();
    },
  );
}
