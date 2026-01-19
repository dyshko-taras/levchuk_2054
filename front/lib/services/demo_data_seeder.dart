import 'package:drift/drift.dart';

import '../constants/app_images.dart';
import '../constants/app_strings.dart';
import '../data/local/database/app_database.dart';
import '../data/local/prefs_store.dart';

/// Seeds the database with example data on first launch.
class DemoDataSeeder {
  const DemoDataSeeder({
    required AppDatabase database,
    required PrefsStore prefs,
  })  : _database = database,
        _prefs = prefs;

  final AppDatabase _database;
  final PrefsStore _prefs;

  Future<void> seedIfNeeded() async {
    if (_prefs.isDemoDataSeeded) return;

    final team1Id = await _seedTeamsAndPlayers();
    final field1Id = await _seedFields();
    await _seedMatches();
    await _seedTactics();

    // Set default team and field
    await _prefs.setDefaultTeamId(team1Id);
    await _prefs.setDefaultFieldId(field1Id);

    await _prefs.setDemoDataSeeded();
  }

  Future<int> _seedTeamsAndPlayers() async {
    // Team 1: FC United (home team)
    final team1Id = await _database.teamsDao.createTeam(
      TeamsCompanion.insert(
        name: 'FC United',
        badgeIcon: Value(AppImages.teamBadges[0]), // badge_01.webp
        homePrimaryColor: const Value(0xFF1565C0), // Blue
        homeSecondaryColor: const Value(0xFFFFFFFF), // White
        awayPrimaryColor: const Value(0xFFFFFFFF), // White
        awaySecondaryColor: const Value(0xFF1565C0), // Blue
        isDefault: const Value(true),
      ),
    );

    // Team 1 players
    final team1Players = [
      ('Alex Johnson', 'GK', 1, true),
      ('Marcus Smith', 'DF', 4, false),
      ('Ryan Davis', 'DF', 5, false),
      ('Chris Wilson', 'DF', 3, false),
      ('Jake Thompson', 'MF', 8, false),
      ('Ethan Brown', 'MF', 6, false),
      ('Noah Martinez', 'MF', 10, false),
      ('Liam Garcia', 'FW', 9, false),
      ('Mason Rodriguez', 'FW', 11, false),
      ('Oliver Lee', 'FW', 7, false),
      ('James Walker', 'DF', 2, false),
    ];

    for (final player in team1Players) {
      await _database.teamsDao.createPlayer(
        PlayersCompanion.insert(
          teamId: team1Id,
          name: player.$1,
          position: Value(player.$2),
          number: Value(player.$3),
          isCaptain: Value(player.$4),
        ),
      );
    }

    // Team 2: City Rovers
    final team2Id = await _database.teamsDao.createTeam(
      TeamsCompanion.insert(
        name: 'City Rovers',
        badgeIcon: Value(AppImages.teamBadges[4]), // badge_05.webp
        homePrimaryColor: const Value(0xFFC62828), // Red
        homeSecondaryColor: const Value(0xFFFFFFFF), // White
        awayPrimaryColor: const Value(0xFF212121), // Black
        awaySecondaryColor: const Value(0xFFC62828), // Red
      ),
    );

    // Team 2 players
    final team2Players = [
      ('Daniel White', 'GK', 1, false),
      ('Michael Harris', 'DF', 2, true),
      ('William Clark', 'DF', 4, false),
      ('Benjamin Lewis', 'DF', 5, false),
      ('Lucas Young', 'MF', 6, false),
      ('Henry King', 'MF', 8, false),
      ('Alexander Wright', 'MF', 10, false),
      ('Sebastian Scott', 'FW', 7, false),
      ('Jack Green', 'FW', 9, false),
      ('Owen Adams', 'FW', 11, false),
    ];

    for (final player in team2Players) {
      await _database.teamsDao.createPlayer(
        PlayersCompanion.insert(
          teamId: team2Id,
          name: player.$1,
          position: Value(player.$2),
          number: Value(player.$3),
          isCaptain: Value(player.$4),
        ),
      );
    }

    return team1Id;
  }

  Future<int> _seedFields() async {
    final field1Id = await _database.fieldsDao.createField(
      FieldsCompanion.insert(
        name: 'Central Park Field',
        address: const Value('123 Park Avenue'),
        type: const Value(AppStrings.fieldType11v11),
        notes: const Value('Full-size outdoor field with parking available'),
      ),
    );

    await _database.fieldsDao.createField(
      FieldsCompanion.insert(
        name: 'Sports Arena',
        address: const Value('456 Stadium Road'),
        type: const Value(AppStrings.fieldType7v7),
        notes: const Value('Indoor field, open year-round'),
      ),
    );

    return field1Id;
  }

  Future<void> _seedMatches() async {
    final now = DateTime.now();

    // Past match (completed) - ID will be 1
    final pastDate = now.subtract(const Duration(days: 7));
    await _database.matchesDao.createMatch(
      MatchesCompanion.insert(
        title: 'FC United vs City Rovers',
        startAt: DateTime(pastDate.year, pastDate.month, pastDate.day, 15),
        endAt: Value(DateTime(pastDate.year, pastDate.month, pastDate.day, 17)),
        fieldId: const Value(1),
        teamAId: const Value(1),
        teamBId: const Value(2),
        status: const Value('completed'),
        scoreA: const Value(3),
        scoreB: const Value(2),
        notes: const Value('Great match with a last-minute goal'),
      ),
    );

    // Today's match (planned) - ID will be 2
    await _database.matchesDao.createMatch(
      MatchesCompanion.insert(
        title: 'City Rovers vs FC United',
        startAt: DateTime(now.year, now.month, now.day, 18),
        endAt: Value(DateTime(now.year, now.month, now.day, 20)),
        fieldId: const Value(2),
        teamAId: const Value(2),
        teamBId: const Value(1),
        status: const Value('planned'),
        notes: const Value('Return leg at Sports Arena'),
      ),
    );

    // Future match (planned) - ID will be 3
    final futureDate = now.add(const Duration(days: 14));
    await _database.matchesDao.createMatch(
      MatchesCompanion.insert(
        title: 'FC United vs City Rovers',
        startAt: DateTime(
          futureDate.year,
          futureDate.month,
          futureDate.day,
          16,
        ),
        endAt: Value(
          DateTime(futureDate.year, futureDate.month, futureDate.day, 18),
        ),
        fieldId: const Value(1),
        teamAId: const Value(1),
        teamBId: const Value(2),
        status: const Value('planned'),
        notes: const Value('Season decider match'),
      ),
    );
  }

  Future<void> _seedTactics() async {
    // Tactics for today's match (match ID 2)
    await _database.tacticsDao.upsertTactics(
      const TacticsCompanion(
        matchId: Value(2),
        pressing: Value('High press in first 20 minutes'),
        width: Value('Wide play on the flanks'),
        buildUp: Value('Short passes from the back'),
        corners: Value('Near post runs'),
        freeKicks: Value('Direct shots from distance'),
        keyMatchups: Value('Noah Martinez vs Michael Harris'),
        notes: Value(
          'Focus on quick transitions and maintaining possession. '
          'Their left side is weaker - exploit with Oliver Lee.',
        ),
      ),
    );

    // Do/Don't items for today's match
    final doDontItems = [
      ("Press high when they're building from the back", false, 0),
      ('Switch play quickly to stretch their defense', false, 1),
      ('Track back on defensive transitions', false, 2),
      ("Don't let #10 get space in the box", false, 3),
      ("Don't commit too many players forward", false, 4),
    ];

    for (final item in doDontItems) {
      await _database.tacticsDao.addDoDontItem(
        DoDontItemsCompanion.insert(
          matchId: 2,
          content: item.$1,
          isDone: Value(item.$2),
          sortOrder: Value(item.$3),
        ),
      );
    }

    // Tactics for future match (match ID 3)
    await _database.tacticsDao.upsertTactics(
      const TacticsCompanion(
        matchId: Value(3),
        pressing: Value('Medium block'),
        width: Value('Compact in the center'),
        buildUp: Value('Mix of short and long balls'),
        corners: Value('Back post delivery'),
        freeKicks: Value('Cross into the box'),
        keyMatchups: Value('Liam Garcia vs William Clark'),
        notes: Value(
          'Season decider - stay calm and play our game. '
          'Home advantage is key.',
        ),
      ),
    );
  }
}
