// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamsTable get teams => attachedDatabase.teams;
  $PlayersTable get players => attachedDatabase.players;
  TeamsDaoManager get managers => TeamsDaoManager(this);
}

class TeamsDaoManager {
  final _$TeamsDaoMixin _db;
  TeamsDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db.attachedDatabase, _db.players);
}
