import '../local/database/app_database.dart';

class MatchesRepository {
  const MatchesRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Stream<List<Fixture>> watchMatches() => _database.matchesDao.watchMatches();

  Future<int> createMatch(MatchesCompanion entry) =>
      _database.matchesDao.createMatch(entry);

  Future<void> updateMatch(Fixture entry) =>
      _database.matchesDao.updateMatch(entry);

  Future<void> deleteMatchById(int matchId) =>
      _database.matchesDao.deleteMatchById(matchId);
}
