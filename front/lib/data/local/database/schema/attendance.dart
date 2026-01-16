import 'package:drift/drift.dart';

class Attendance extends Table {
  IntColumn get matchId => integer()();
  IntColumn get teamId => integer()();
  IntColumn get playerId => integer()();

  BoolColumn get isComing => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {matchId, teamId, playerId};
}
