import '../local/database/app_database.dart';

class TeamDirectoryItem {
  const TeamDirectoryItem({required this.team, required this.playersCount});

  final Team team;
  final int playersCount;
}
