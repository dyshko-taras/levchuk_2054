import 'package:drift/drift.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get teamId => integer()();
  TextColumn get name => text()();
  TextColumn get position => text().nullable()();

  BoolColumn get isCaptain => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
