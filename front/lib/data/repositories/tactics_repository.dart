import '../local/database/app_database.dart';

class TacticsRepository {
  const TacticsRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Stream<Tactic?> watchTactics(int matchId) =>
      _database.tacticsDao.watchTactics(matchId);

  Stream<List<DoDontItem>> watchDoDontItems(int matchId) =>
      _database.tacticsDao.watchDoDontItems(matchId);

  Future<void> upsertTactics(TacticsCompanion entry) =>
      _database.tacticsDao.upsertTactics(entry);

  Future<int> addDoDontItem(DoDontItemsCompanion entry) =>
      _database.tacticsDao.addDoDontItem(entry);

  Future<void> updateDoDontItem(DoDontItem entry) =>
      _database.tacticsDao.updateDoDontItem(entry);

  Future<void> deleteDoDontItemById(int id) =>
      _database.tacticsDao.deleteDoDontItemById(id);
}
