import 'package:drift/drift.dart';

import '../app_database.dart';
import '../../../models/team_directory_item.dart';
import '../schema/players.dart';
import '../schema/teams.dart';

part 'teams_dao.g.dart';

@DriftAccessor(tables: [Teams, Players])
class TeamsDao extends DatabaseAccessor<AppDatabase> with _$TeamsDaoMixin {
  TeamsDao(super.db);

  Stream<List<Team>> watchTeams() => select(teams).watch();

  Stream<List<TeamDirectoryItem>> watchTeamsDirectory() {
    final query =
        select(teams).join([
            leftOuterJoin(players, players.teamId.equalsExp(teams.id)),
          ])
          ..addColumns([players.id.count()])
          ..groupBy([teams.id])
          ..orderBy([OrderingTerm.asc(teams.name)]);

    return query.watch().map((rows) {
      return rows
          .map((row) {
            final team = row.readTable(teams);
            final count = row.read(players.id.count()) ?? 0;
            return TeamDirectoryItem(team: team, playersCount: count);
          })
          .toList(growable: false);
    });
  }

  Future<int> createTeam(TeamsCompanion entry) => into(teams).insert(entry);

  Future<void> updateTeam(Team entry) => update(teams).replace(entry);

  Future<void> deleteTeamById(int teamId) async {
    await (delete(players)..where((p) => p.teamId.equals(teamId))).go();
    await (delete(teams)..where((t) => t.id.equals(teamId))).go();
  }

  Future<Team?> findByName(String name) {
    return (select(teams)..where((t) => t.name.equals(name))).getSingleOrNull();
  }

  Future<void> setDefaultTeamFlag(int teamId) async {
    await transaction(() async {
      await (update(teams)..where((t) => t.isDefault.equals(true))).write(
        const TeamsCompanion(isDefault: Value(false)),
      );
      await (update(teams)..where((t) => t.id.equals(teamId))).write(
        const TeamsCompanion(isDefault: Value(true)),
      );
    });
  }

  Future<void> clearDefaultTeamFlag() async {
    await (update(teams)..where((t) => t.isDefault.equals(true))).write(
      const TeamsCompanion(isDefault: Value(false)),
    );
  }

  Stream<List<Player>> watchPlayersByTeam(int teamId) {
    return (select(players)
          ..where((p) => p.teamId.equals(teamId))
          ..orderBy([(p) => OrderingTerm.asc(p.name)]))
        .watch();
  }

  Future<int> createPlayer(PlayersCompanion entry) =>
      into(players).insert(entry);

  Future<void> updatePlayer(Player entry) => update(players).replace(entry);

  Future<void> deletePlayerById(int playerId) =>
      (delete(players)..where((p) => p.id.equals(playerId))).go();
}
