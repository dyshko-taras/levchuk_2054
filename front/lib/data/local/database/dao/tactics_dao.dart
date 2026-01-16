import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/do_dont_items.dart';
import '../schema/tactics.dart';

part 'tactics_dao.g.dart';

@DriftAccessor(tables: [Tactics, DoDontItems])
class TacticsDao extends DatabaseAccessor<AppDatabase> with _$TacticsDaoMixin {
  TacticsDao(super.db);

  Stream<Tactic?> watchTactics(int matchId) => (select(
    tactics,
  )..where((t) => t.matchId.equals(matchId))).watchSingleOrNull();

  Stream<List<DoDontItem>> watchDoDontItems(int matchId) =>
      (select(doDontItems)
            ..where((i) => i.matchId.equals(matchId))
            ..orderBy([(i) => OrderingTerm.asc(i.sortOrder)]))
          .watch();

  Future<void> upsertTactics(TacticsCompanion entry) =>
      into(tactics).insertOnConflictUpdate(entry);

  Future<int> addDoDontItem(DoDontItemsCompanion entry) =>
      into(doDontItems).insert(entry);

  Future<void> updateDoDontItem(DoDontItem entry) =>
      update(doDontItems).replace(entry);

  Future<void> deleteDoDontItemById(int id) =>
      (delete(doDontItems)..where((i) => i.id.equals(id))).go();
}
