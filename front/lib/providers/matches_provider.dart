import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/matches_repository.dart';

class MatchesProvider extends ChangeNotifier {
  MatchesProvider({required MatchesRepository repository})
    : _repository = repository {
    _matchesSubscription = _repository.watchMatches().listen((value) {
      _matches = value;
      notifyListeners();
    });
  }

  final MatchesRepository _repository;

  StreamSubscription<List<Fixture>>? _matchesSubscription;
  List<Fixture> _matches = const [];

  List<Fixture> get matches => _matches;

  Future<int> createMatch({
    required String title,
    required DateTime startAt,
    DateTime? endAt,
    int? fieldId,
    int? teamAId,
    int? teamBId,
    String status = 'planned',
    String? result,
    int? scoreA,
    int? scoreB,
    String? notes,
  }) {
    return _repository.createMatch(
      MatchesCompanion.insert(
        title: title,
        startAt: startAt,
        endAt: Value(endAt),
        fieldId: Value(fieldId),
        teamAId: Value(teamAId),
        teamBId: Value(teamBId),
        status: Value(status),
        result: Value(result),
        scoreA: Value(scoreA),
        scoreB: Value(scoreB),
        notes: Value(notes),
      ),
    );
  }

  Future<void> updateMatch(Fixture fixture) => _repository.updateMatch(fixture);

  Future<void> deleteMatchById(int matchId) =>
      _repository.deleteMatchById(matchId);

  @override
  void dispose() {
    _matchesSubscription?.cancel();
    super.dispose();
  }
}
