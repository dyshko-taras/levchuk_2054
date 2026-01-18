import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/lineup_repository.dart';

class LineupProvider extends ChangeNotifier {
  LineupProvider({required LineupRepository repository})
    : _repository = repository;

  final LineupRepository _repository;

  Stream<Lineup?> watchLineup(int matchId, int teamId) =>
      _repository.watchLineup(matchId, teamId);

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) =>
      _repository.watchLineupSlots(matchId, teamId);

  Future<void> replaceLineupSlots({
    required int matchId,
    required int teamId,
    required List<LineupSlotsCompanion> entries,
  }) {
    return _repository.replaceLineupSlots(matchId, teamId, entries);
  }

  Stream<List<AttendanceData>> watchAttendance(int matchId, int teamId) =>
      _repository.watchAttendance(matchId, teamId);

  Stream<MatchLogistic?> watchMatchLogistics(int matchId) =>
      _repository.watchMatchLogistics(matchId);

  Future<void> upsertLineup({
    required int matchId,
    required int teamId,
    required String formation,
  }) {
    return _repository.upsertLineup(
      LineupsCompanion.insert(
        matchId: matchId,
        teamId: teamId,
        formation: Value(formation),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> addLineupSlot({
    required int matchId,
    required int teamId,
    required int slotIndex,
    String? position,
    int? playerId,
  }) {
    return _repository.addLineupSlot(
      LineupSlotsCompanion.insert(
        matchId: matchId,
        teamId: teamId,
        slotIndex: slotIndex,
        position: Value(position),
        playerId: Value(playerId),
      ),
    );
  }

  Future<void> setAttendance({
    required int matchId,
    required int teamId,
    required int playerId,
    required bool isComing,
  }) {
    return _repository.setAttendance(
      AttendanceCompanion.insert(
        matchId: matchId,
        teamId: teamId,
        playerId: playerId,
        isComing: Value(isComing),
      ),
    );
  }

  Future<void> upsertMatchLogistics({
    required int matchId,
    double? pitchFeeTotal,
    String splitMode = 'confirmed',
    DateTime? meetTime,
    bool bringCash = false,
    bool bringBibs = false,
    bool bringBall = false,
    bool bringWater = false,
    String? crewNotes,
  }) {
    return _repository.upsertMatchLogistics(
      MatchLogisticsCompanion.insert(
        matchId: Value(matchId),
        pitchFeeTotal: Value(pitchFeeTotal),
        splitMode: Value(splitMode),
        meetTime: Value(meetTime),
        bringCash: Value(bringCash),
        bringBibs: Value(bringBibs),
        bringBall: Value(bringBall),
        bringWater: Value(bringWater),
        crewNotes: Value(crewNotes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
