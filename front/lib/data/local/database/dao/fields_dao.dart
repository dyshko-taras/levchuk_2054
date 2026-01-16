import 'package:drift/drift.dart';

import '../app_database.dart';
import '../schema/fields.dart';

part 'fields_dao.g.dart';

@DriftAccessor(tables: [Fields])
class FieldsDao extends DatabaseAccessor<AppDatabase> with _$FieldsDaoMixin {
  FieldsDao(super.db);

  Stream<List<Field>> watchFields() => select(fields).watch();

  Future<int> createField(FieldsCompanion entry) => into(fields).insert(entry);

  Future<void> updateField(Field entry) => update(fields).replace(entry);

  Future<void> deleteFieldById(int fieldId) =>
      (delete(fields)..where((f) => f.id.equals(fieldId))).go();
}
