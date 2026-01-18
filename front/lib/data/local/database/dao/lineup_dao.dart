import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/attendance.dart';
import '../schema/lineup_slots.dart';
import '../schema/lineups.dart';
import '../schema/match_logistics.dart';

part 'lineup_dao.g.dart';

@DriftAccessor(tables: [Lineups, LineupSlots, Attendance, MatchLogistics])
class LineupDao extends DatabaseAccessor<AppDatabase> with _$LineupDaoMixin {
  LineupDao(super.db);

  Stream<Lineup?> watchLineup(int matchId, int teamId) {
    return (select(lineups)
          ..where((l) => l.matchId.equals(matchId) & l.teamId.equals(teamId)))
        .watchSingleOrNull();
  }

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) {
    return (select(lineupSlots)
          ..where((s) => s.matchId.equals(matchId) & s.teamId.equals(teamId))
          ..orderBy([(s) => OrderingTerm.asc(s.slotIndex)]))
        .watch();
  }

  Future<void> replaceLineupSlots(
    int matchId,
    int teamId,
    List<LineupSlotsCompanion> entries,
  ) async {
    await transaction(() async {
      await (delete(lineupSlots)
            ..where(
              (s) => s.matchId.equals(matchId) & s.teamId.equals(teamId),
            ))
          .go();
      await batch((b) => b.insertAll(lineupSlots, entries));
    });
  }

  Stream<List<AttendanceData>> watchAttendance(int matchId, int teamId) {
    return (select(attendance)
          ..where((a) => a.matchId.equals(matchId) & a.teamId.equals(teamId)))
        .watch();
  }

  Stream<MatchLogistic?> watchMatchLogistics(int matchId) {
    return (select(matchLogistics)..where((l) => l.matchId.equals(matchId)))
        .watchSingleOrNull();
  }

  Future<void> upsertLineup(LineupsCompanion entry) =>
      into(lineups).insertOnConflictUpdate(entry);

  Future<int> addLineupSlot(LineupSlotsCompanion entry) =>
      into(lineupSlots).insert(entry);

  Future<void> setAttendance(AttendanceCompanion entry) =>
      into(attendance).insertOnConflictUpdate(entry);

  Future<void> upsertMatchLogistics(MatchLogisticsCompanion entry) =>
      into(matchLogistics).insertOnConflictUpdate(entry);
}
