import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/lineup_repository.dart';

class LineupProvider extends ChangeNotifier {
  LineupProvider({required LineupRepository repository})
    : _repository = repository;

  final LineupRepository _repository;

  Stream<List<LineupSlot>> watchLineupSlots(int matchId, int teamId) =>
      _repository.watchLineupSlots(matchId, teamId);

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
}
