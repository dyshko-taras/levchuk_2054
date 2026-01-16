import 'package:drift/drift.dart';

class SettingsEntries extends Table {
  TextColumn get key => text()();

  TextColumn get stringValue => text().nullable()();
  IntColumn get intValue => integer().nullable()();
  BoolColumn get boolValue => boolean().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
