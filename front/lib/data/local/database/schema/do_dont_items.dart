import 'package:drift/drift.dart';

class DoDontItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get matchId => integer()();

  TextColumn get content => text()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
