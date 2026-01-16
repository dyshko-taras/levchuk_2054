import 'package:drift/drift.dart';

@DataClassName('Fixture')
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get startAt => dateTime()();

  IntColumn get fieldId => integer().nullable()();

  IntColumn get teamAId => integer().nullable()();
  IntColumn get teamBId => integer().nullable()();

  TextColumn get status => text().withDefault(const Constant('planned'))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
