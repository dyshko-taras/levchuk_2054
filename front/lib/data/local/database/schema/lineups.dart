import 'package:drift/drift.dart';

class Lineups extends Table {
  IntColumn get matchId => integer()();
  IntColumn get teamId => integer()();

  TextColumn get formation => text().withDefault(const Constant('4-4-2'))();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {matchId, teamId};
}
