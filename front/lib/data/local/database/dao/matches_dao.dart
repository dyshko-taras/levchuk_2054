import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/matches.dart';

part 'matches_dao.g.dart';

@DriftAccessor(tables: [Matches])
class MatchesDao extends DatabaseAccessor<AppDatabase> with _$MatchesDaoMixin {
  MatchesDao(super.db);

  Stream<List<Fixture>> watchMatches() => select(matches).watch();

  Future<int> createMatch(MatchesCompanion entry) =>
      into(matches).insert(entry);

  Future<void> updateMatch(Fixture entry) => update(matches).replace(entry);

  Future<void> deleteMatchById(int matchId) =>
      (delete(matches)..where((m) => m.id.equals(matchId))).go();

  Future<int> countMatchesByTeamId(int teamId) async {
    final expr =
        matches.teamAId.equals(teamId) | matches.teamBId.equals(teamId);
    final query = selectOnly(matches)..addColumns([matches.id.count()]);
    query.where(expr);
    final row = await query.getSingle();
    return row.read(matches.id.count()) ?? 0;
  }

  Future<int> countPlannedMatchesByFieldId(int fieldId) async {
    final expr =
        matches.fieldId.equals(fieldId) & matches.status.equals('planned');
    final query = selectOnly(matches)..addColumns([matches.id.count()]);
    query.where(expr);
    final row = await query.getSingle();
    return row.read(matches.id.count()) ?? 0;
  }
}
