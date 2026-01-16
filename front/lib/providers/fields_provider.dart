import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/fields_repository.dart';

class FieldsProvider extends ChangeNotifier {
  FieldsProvider({required FieldsRepository repository})
    : _repository = repository {
    _fieldsSubscription = _repository.watchFields().listen((value) {
      _fields = value;
      notifyListeners();
    });
  }

  final FieldsRepository _repository;

  StreamSubscription<List<Field>>? _fieldsSubscription;
  List<Field> _fields = const [];

  List<Field> get fields => _fields;

  Future<int> createField({
    required String name,
    String? address,
    String? notes,
    String? photoPath,
  }) {
    return _repository.createField(
      FieldsCompanion.insert(
        name: name,
        address: Value(address),
        notes: Value(notes),
        photoPath: Value(photoPath),
      ),
    );
  }

  Future<void> updateField(Field field) => _repository.updateField(field);

  Future<void> deleteFieldById(int fieldId) =>
      _repository.deleteFieldById(fieldId);

  @override
  void dispose() {
    _fieldsSubscription?.cancel();
    super.dispose();
  }
}
