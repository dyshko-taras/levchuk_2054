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
    required String address,
    String? type,
    String? notes,
    double? lat,
    double? lon,
    String? photoPath,
  }) {
    return _repository.createField(
      FieldsCompanion.insert(
        name: name,
        address: Value(address),
        type: Value(type),
        notes: Value(notes),
        lat: Value(lat),
        lon: Value(lon),
        photoPath: Value(photoPath),
      ),
    );
  }

  Future<void> updateField(Field field) => _repository.updateField(field);

  Future<void> deleteFieldById(int fieldId) =>
      _repository.deleteFieldById(fieldId);

  Future<bool> canDeleteField(int fieldId) async {
    final usedPlannedMatchesCount = await _repository
        .countPlannedMatchesByFieldId(
          fieldId,
        );
    return usedPlannedMatchesCount == 0;
  }

  @override
  void dispose() {
    _fieldsSubscription?.cancel();
    super.dispose();
  }
}
