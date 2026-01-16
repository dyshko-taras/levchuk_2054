// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields_dao.dart';

// ignore_for_file: type=lint
mixin _$FieldsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  FieldsDaoManager get managers => FieldsDaoManager(this);
}

class FieldsDaoManager {
  final _$FieldsDaoMixin _db;
  FieldsDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
}
