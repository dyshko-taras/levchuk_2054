import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/attendance.dart';
import '../schema/lineup_slots.dart';
import '../schema/lineups.dart';

part 'lineup_dao.g.dart';

@DriftAccessor(tables: [Lineups, LineupSlots, Attendance])
class LineupDao extends DatabaseAccessor<AppDatabase> with _$LineupDaoMixin {
  LineupDao(super.db);

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) {
    return (select(lineupSlots)
          ..where((s) => s.matchId.equals(matchId) & s.teamId.equals(teamId))
          ..orderBy([(s) => OrderingTerm.asc(s.slotIndex)]))
        .watch();
  }

  Future<void> upsertLineup(LineupsCompanion entry) =>
      into(lineups).insertOnConflictUpdate(entry);

  Future<int> addLineupSlot(LineupSlotsCompanion entry) =>
      into(lineupSlots).insert(entry);

  Future<void> setAttendance(AttendanceCompanion entry) =>
      into(attendance).insertOnConflictUpdate(entry);
}
