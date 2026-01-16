import '../local/database/app_database.dart';

class FieldsRepository {
  const FieldsRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Stream<List<Field>> watchFields() => _database.fieldsDao.watchFields();

  Future<int> createField(FieldsCompanion entry) =>
      _database.fieldsDao.createField(entry);

  Future<void> updateField(Field entry) =>
      _database.fieldsDao.updateField(entry);

  Future<void> deleteFieldById(int fieldId) =>
      _database.fieldsDao.deleteFieldById(fieldId);
}
