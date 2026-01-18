// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup_dao.dart';

// ignore_for_file: type=lint
mixin _$LineupDaoMixin on DatabaseAccessor<AppDatabase> {
  $LineupsTable get lineups => attachedDatabase.lineups;
  $LineupSlotsTable get lineupSlots => attachedDatabase.lineupSlots;
  $AttendanceTable get attendance => attachedDatabase.attendance;
  $MatchLogisticsTable get matchLogistics => attachedDatabase.matchLogistics;
  LineupDaoManager get managers => LineupDaoManager(this);
}

class LineupDaoManager {
  final _$LineupDaoMixin _db;
  LineupDaoManager(this._db);
  $$LineupsTableTableManager get lineups =>
      $$LineupsTableTableManager(_db.attachedDatabase, _db.lineups);
  $$LineupSlotsTableTableManager get lineupSlots =>
      $$LineupSlotsTableTableManager(_db.attachedDatabase, _db.lineupSlots);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db.attachedDatabase, _db.attendance);
  $$MatchLogisticsTableTableManager get matchLogistics =>
      $$MatchLogisticsTableTableManager(
        _db.attachedDatabase,
        _db.matchLogistics,
      );
}
