import '../local/database/app_database.dart';

class LineupRepository {
  const LineupRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) =>
      _database.lineupDao.watchLineupSlots(matchId, teamId);

  Future<void> upsertLineup(LineupsCompanion entry) =>
      _database.lineupDao.upsertLineup(entry);

  Future<int> addLineupSlot(LineupSlotsCompanion entry) =>
      _database.lineupDao.addLineupSlot(entry);

  Future<void> setAttendance(AttendanceCompanion entry) =>
      _database.lineupDao.setAttendance(entry);
}
