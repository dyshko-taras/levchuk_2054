import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_config.dart';
import 'constants/app_routes.dart';
import 'data/local/database/app_database.dart';
import 'data/local/prefs_store.dart';
import 'data/repositories/fields_repository.dart';
import 'data/repositories/lineup_repository.dart';
import 'data/repositories/matches_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/repositories/stats_repository.dart';
import 'data/repositories/tactics_repository.dart';
import 'data/repositories/teams_repository.dart';
import 'providers/fields_provider.dart';
import 'providers/lineup_provider.dart';
import 'providers/matches_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/stats_provider.dart';
import 'providers/tactics_provider.dart';
import 'providers/teams_provider.dart';
import 'ui/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_AppDependencies>(
      future: _AppDependencies.create(),
      builder: (context, snapshot) {
        final deps = snapshot.data;
        if (deps == null) {
          return const SizedBox.shrink();
        }

        return MultiProvider(
          providers: [
            Provider<AppDatabase>(
              create: (_) => deps.database,
              dispose: (_, AppDatabase db) => unawaited(db.close()),
            ),
            Provider<PrefsStore>.value(value: deps.prefs),
            Provider<SettingsRepository>.value(value: deps.settingsRepository),
            Provider<TeamsRepository>.value(value: deps.teamsRepository),
            Provider<FieldsRepository>.value(value: deps.fieldsRepository),
            Provider<MatchesRepository>.value(value: deps.matchesRepository),
            Provider<LineupRepository>.value(value: deps.lineupRepository),
            Provider<TacticsRepository>.value(value: deps.tacticsRepository),
            Provider<StatsRepository>.value(value: deps.statsRepository),
            ChangeNotifierProvider<SettingsProvider>(
              create: (_) =>
                  SettingsProvider(repository: deps.settingsRepository),
            ),
            ChangeNotifierProvider<TeamsProvider>(
              create: (_) => TeamsProvider(repository: deps.teamsRepository),
            ),
            ChangeNotifierProvider<FieldsProvider>(
              create: (_) => FieldsProvider(repository: deps.fieldsRepository),
            ),
            ChangeNotifierProvider<MatchesProvider>(
              create: (_) =>
                  MatchesProvider(repository: deps.matchesRepository),
            ),
            ChangeNotifierProvider<LineupProvider>(
              create: (_) => LineupProvider(repository: deps.lineupRepository),
            ),
            ChangeNotifierProvider<TacticsProvider>(
              create: (_) =>
                  TacticsProvider(repository: deps.tacticsRepository),
            ),
            ChangeNotifierProvider<StatsProvider>(
              create: (_) => StatsProvider(repository: deps.statsRepository),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConfig.appName,
            theme: appTheme,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}

class _AppDependencies {
  _AppDependencies._({
    required this.database,
    required this.prefs,
    required this.settingsRepository,
    required this.teamsRepository,
    required this.fieldsRepository,
    required this.matchesRepository,
    required this.lineupRepository,
    required this.tacticsRepository,
    required this.statsRepository,
  });

  final AppDatabase database;
  final PrefsStore prefs;

  final SettingsRepository settingsRepository;
  final TeamsRepository teamsRepository;
  final FieldsRepository fieldsRepository;
  final MatchesRepository matchesRepository;
  final LineupRepository lineupRepository;
  final TacticsRepository tacticsRepository;
  final StatsRepository statsRepository;

  static Future<_AppDependencies> create() async {
    final prefs = await PrefsStore.create();
    final database = AppDatabase();

    return _AppDependencies._(
      database: database,
      prefs: prefs,
      settingsRepository: SettingsRepository(database: database, prefs: prefs),
      teamsRepository: TeamsRepository(database: database),
      fieldsRepository: FieldsRepository(database: database),
      matchesRepository: MatchesRepository(database: database),
      lineupRepository: LineupRepository(database: database),
      tacticsRepository: TacticsRepository(database: database),
      statsRepository: const StatsRepository(),
    );
  }
}
