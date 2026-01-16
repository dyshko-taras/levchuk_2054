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
}
