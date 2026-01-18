import 'package:drift/drift.dart';

class MatchLogistics extends Table {
  IntColumn get matchId => integer()();

  RealColumn get pitchFeeTotal => real().nullable()();
  TextColumn get splitMode =>
      text().withDefault(const Constant('confirmed'))();

  DateTimeColumn get meetTime => dateTime().nullable()();

  BoolColumn get bringCash => boolean().withDefault(const Constant(false))();
  BoolColumn get bringBibs => boolean().withDefault(const Constant(false))();
  BoolColumn get bringBall => boolean().withDefault(const Constant(false))();
  BoolColumn get bringWater => boolean().withDefault(const Constant(false))();

  TextColumn get crewNotes => text().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {matchId};
}

