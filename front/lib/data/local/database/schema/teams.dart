import 'package:drift/drift.dart';

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get badgeIcon => text().nullable()();

  TextColumn get homeKitTemplateId =>
      text().withDefault(const Constant('default'))();
  IntColumn get homePrimaryColor => integer().nullable()();
  IntColumn get homeSecondaryColor => integer().nullable()();

  TextColumn get awayKitTemplateId =>
      text().withDefault(const Constant('default'))();
  IntColumn get awayPrimaryColor => integer().nullable()();
  IntColumn get awaySecondaryColor => integer().nullable()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
