import 'package:drift/drift.dart';

@DataClassName('Fixture')
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime().nullable()();

  IntColumn get fieldId => integer().nullable()();

  IntColumn get teamAId => integer().nullable()();
  IntColumn get teamBId => integer().nullable()();

  TextColumn get status => text().withDefault(const Constant('planned'))();

  TextColumn get result => text().nullable()();
  IntColumn get scoreA => integer().nullable()();
  IntColumn get scoreB => integer().nullable()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
