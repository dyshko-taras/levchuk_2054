import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_database.dart';
import '../data/models/team_directory_item.dart';
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

  Stream<List<TeamDirectoryItem>> watchTeamsDirectory() =>
      _repository.watchTeamsDirectory();

  Future<int> createTeam({
    required String name,
    String? badgeIcon,
    String homeKitTemplateId = 'default',
    int? homePrimaryColor,
    int? homeSecondaryColor,
    String awayKitTemplateId = 'default',
    int? awayPrimaryColor,
    int? awaySecondaryColor,
  }) {
    return _repository.createTeam(
      TeamsCompanion.insert(
        name: name,
        badgeIcon: Value(badgeIcon),
        homeKitTemplateId: Value(homeKitTemplateId),
        homePrimaryColor: Value(homePrimaryColor),
        homeSecondaryColor: Value(homeSecondaryColor),
        awayKitTemplateId: Value(awayKitTemplateId),
        awayPrimaryColor: Value(awayPrimaryColor),
        awaySecondaryColor: Value(awaySecondaryColor),
      ),
    );
  }

  Future<void> updateTeam(Team team) => _repository.updateTeam(team);

  Future<void> deleteTeamById(int teamId) => _repository.deleteTeamById(teamId);

  Future<int> createPlayer({
    required int teamId,
    required String name,
    String? position,
    int? number,
    bool isCaptain = false,
  }) {
    return _repository.createPlayer(
      PlayersCompanion.insert(
        teamId: teamId,
        name: name,
        position: Value(position),
        number: Value(number),
        isCaptain: Value(isCaptain),
      ),
    );
  }

  Future<void> updatePlayer(Player player) => _repository.updatePlayer(player);

  Future<void> deletePlayerById(int playerId) =>
      _repository.deletePlayerById(playerId);

  Future<bool> isTeamNameUnique(String name, {int? excludeTeamId}) async {
    final existing = await _repository.findTeamByName(name);
    if (existing == null) return true;
    if (excludeTeamId == null) return false;
    return existing.id == excludeTeamId;
  }

  Future<bool> canDeleteTeam(int teamId) async {
    final usedMatchesCount = await _repository.countMatchesByTeamId(teamId);
    return usedMatchesCount == 0;
  }

  Future<void> setDefaultTeamFlag(int teamId) =>
      _repository.setDefaultTeamFlag(teamId);

  @override
  void dispose() {
    _teamsSubscription?.cancel();
    super.dispose();
  }
}
