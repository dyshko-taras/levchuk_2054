import 'package:drift/drift.dart';

class Tactics extends Table {
  IntColumn get matchId => integer()();

  TextColumn get pressing => text().nullable()();
  TextColumn get width => text().nullable()();
  TextColumn get buildUp => text().nullable()();

  TextColumn get corners => text().nullable()();
  TextColumn get freeKicks => text().nullable()();

  TextColumn get keyMatchups => text().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {matchId};
}
