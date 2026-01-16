import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/teams_repository.dart';

class TeamsProvider extends ChangeNotifier {
  TeamsProvider({required TeamsRepository repository})
    : _repository = repository {
    _teamsSubscription = _repository.watchTeams().listen((value) {
      _teams = value;
      notifyListeners();
    });
  }

  final TeamsRepository _repository;

  StreamSubscription<List<Team>>? _teamsSubscription;
  List<Team> _teams = const [];

  List<Team> get teams => _teams;

  Stream<List<Player>> watchPlayersByTeam(int teamId) =>
      _repository.watchPlayersByTeam(teamId);

  Future<int> createTeam({
    required String name,
    String? badgeIcon,
    int? homeColor,
    int? awayColor,
  }) {
    return _repository.createTeam(
      TeamsCompanion.insert(
        name: name,
        badgeIcon: Value(badgeIcon),
        homeColor: Value(homeColor),
        awayColor: Value(awayColor),
      ),
    );
  }

  Future<void> updateTeam(Team team) => _repository.updateTeam(team);

  Future<void> deleteTeamById(int teamId) => _repository.deleteTeamById(teamId);

  Future<int> createPlayer({
    required int teamId,
    required String name,
    String? position,
    bool isCaptain = false,
  }) {
    return _repository.createPlayer(
      PlayersCompanion.insert(
        teamId: teamId,
        name: name,
        position: Value(position),
        isCaptain: Value(isCaptain),
      ),
    );
  }

  Future<void> updatePlayer(Player player) => _repository.updatePlayer(player);

  Future<void> deletePlayerById(int playerId) =>
      _repository.deletePlayerById(playerId);

  @override
  void dispose() {
    _teamsSubscription?.cancel();
    super.dispose();
  }
}
