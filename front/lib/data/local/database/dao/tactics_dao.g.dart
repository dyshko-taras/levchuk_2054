// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactics_dao.dart';

// ignore_for_file: type=lint
mixin _$TacticsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TacticsTable get tactics => attachedDatabase.tactics;
  $DoDontItemsTable get doDontItems => attachedDatabase.doDontItems;
  TacticsDaoManager get managers => TacticsDaoManager(this);
}

class TacticsDaoManager {
  final _$TacticsDaoMixin _db;
  TacticsDaoManager(this._db);
  $$TacticsTableTableManager get tactics =>
      $$TacticsTableTableManager(_db.attachedDatabase, _db.tactics);
  $$DoDontItemsTableTableManager get doDontItems =>
      $$DoDontItemsTableTableManager(_db.attachedDatabase, _db.doDontItems);
}
