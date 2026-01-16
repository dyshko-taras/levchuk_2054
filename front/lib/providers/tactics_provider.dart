import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/tactics_repository.dart';

class TacticsProvider extends ChangeNotifier {
  TacticsProvider({required TacticsRepository repository})
    : _repository = repository;

  final TacticsRepository _repository;

  Stream<Tactic?> watchTactics(int matchId) =>
      _repository.watchTactics(matchId);

  Stream<List<DoDontItem>> watchDoDontItems(int matchId) =>
      _repository.watchDoDontItems(matchId);

  Future<void> upsertTactics({
    required int matchId,
    String? pressing,
    String? width,
    String? buildUp,
    String? corners,
    String? freeKicks,
    String? keyMatchups,
    String? notes,
  }) {
    return _repository.upsertTactics(
      TacticsCompanion.insert(
        matchId: Value(matchId),
        pressing: Value(pressing),
        width: Value(width),
        buildUp: Value(buildUp),
        corners: Value(corners),
        freeKicks: Value(freeKicks),
        keyMatchups: Value(keyMatchups),
        notes: Value(notes),
      ),
    );
  }

  Future<int> addDoDontItem({
    required int matchId,
    required String content,
    bool isDone = false,
    int sortOrder = 0,
  }) {
    return _repository.addDoDontItem(
      DoDontItemsCompanion.insert(
        matchId: matchId,
        content: content,
        isDone: Value(isDone),
        sortOrder: Value(sortOrder),
      ),
    );
  }

  Future<void> updateDoDontItem(DoDontItem item) =>
      _repository.updateDoDontItem(item);

  Future<void> deleteDoDontItemById(int id) =>
      _repository.deleteDoDontItemById(id);
}
