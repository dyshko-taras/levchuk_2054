import 'package:drift/drift.dart';

class LineupSlots extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get matchId => integer()();
  IntColumn get teamId => integer()();

  IntColumn get slotIndex => integer()();
  TextColumn get position => text().nullable()();

  IntColumn get playerId => integer().nullable()();
}
