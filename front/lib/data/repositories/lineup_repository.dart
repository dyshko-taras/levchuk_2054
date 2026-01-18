import '../local/database/app_database.dart';

class LineupRepository {
  const LineupRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Stream<Lineup?> watchLineup(int matchId, int teamId) =>
      _database.lineupDao.watchLineup(matchId, teamId);

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) =>
      _database.lineupDao.watchLineupSlots(matchId, teamId);

  Future<void> replaceLineupSlots(
    int matchId,
    int teamId,
    List<LineupSlotsCompanion> entries,
  ) => _database.lineupDao.replaceLineupSlots(matchId, teamId, entries);

  Stream<List<AttendanceData>> watchAttendance(int matchId, int teamId) =>
      _database.lineupDao.watchAttendance(matchId, teamId);

  Stream<MatchLogistic?> watchMatchLogistics(int matchId) =>
      _database.lineupDao.watchMatchLogistics(matchId);

  Future<void> upsertLineup(LineupsCompanion entry) =>
      _database.lineupDao.upsertLineup(entry);

  Future<int> addLineupSlot(LineupSlotsCompanion entry) =>
      _database.lineupDao.addLineupSlot(entry);

  Future<void> setAttendance(AttendanceCompanion entry) =>
      _database.lineupDao.setAttendance(entry);

  Future<void> upsertMatchLogistics(MatchLogisticsCompanion entry) =>
      _database.lineupDao.upsertMatchLogistics(entry);
}
