import '../local/database/app_database.dart';

class TeamsRepository {
  const TeamsRepository({required AppDatabase database}) : _database = database;

  final AppDatabase _database;

  Stream<List<Team>> watchTeams() => _database.teamsDao.watchTeams();

  Future<int> createTeam(TeamsCompanion entry) =>
      _database.teamsDao.createTeam(entry);

  Future<void> updateTeam(Team entry) => _database.teamsDao.updateTeam(entry);

  Future<void> deleteTeamById(int teamId) =>
      _database.teamsDao.deleteTeamById(teamId);

  Future<Team?> findTeamByName(String name) =>
      _database.teamsDao.findByName(name);

  Future<void> setDefaultTeamFlag(int teamId) =>
      _database.teamsDao.setDefaultTeamFlag(teamId);

  Future<int> countMatchesByTeamId(int teamId) =>
      _database.matchesDao.countMatchesByTeamId(teamId);

  Stream<List<Player>> watchPlayersByTeam(int teamId) =>
      _database.teamsDao.watchPlayersByTeam(teamId);

  Future<int> createPlayer(PlayersCompanion entry) =>
      _database.teamsDao.createPlayer(entry);

  Future<void> updatePlayer(Player entry) =>
      _database.teamsDao.updatePlayer(entry);

  Future<void> deletePlayerById(int playerId) =>
      _database.teamsDao.deletePlayerById(playerId);
}
