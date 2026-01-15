import 'package:flutter/widgets.dart';

import '../ui/pages/availability_grid_page.dart';
import '../ui/pages/field_form_page.dart';
import '../ui/pages/fields_registry_page.dart';
import '../ui/pages/hub_page.dart';
import '../ui/pages/lineup_tactics_board_page.dart';
import '../ui/pages/match_center_page.dart';
import '../ui/pages/match_composer_page.dart';
import '../ui/pages/onboarding_page.dart';
import '../ui/pages/privacy_page.dart';
import '../ui/pages/settings_page.dart';
import '../ui/pages/splash_page.dart';
import '../ui/pages/stats_page.dart';
import '../ui/pages/team_studio_page.dart';
import '../ui/pages/teams_directory_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String hub = '/hub';
  static const String teamStudio = '/team-studio';
  static const String teamsDirectory = '/teams';
  static const String fieldsRegistry = '/fields';
  static const String fieldForm = '/field-form';
  static const String availability = '/availability';
  static const String matchComposer = '/match-composer';
  static const String matchCenter = '/match-center';
  static const String lineupTactics = '/lineup-tactics';
  static const String stats = '/stats';
  static const String settings = '/settings';
  static const String privacy = '/privacy';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    splash: (_) => const SplashPage(),
    onboarding: (_) => const OnboardingPage(),
    hub: (_) => const HubPage(),
    teamStudio: (_) => const TeamStudioPage(),
    teamsDirectory: (_) => const TeamsDirectoryPage(),
    fieldsRegistry: (_) => const FieldsRegistryPage(),
    fieldForm: (_) => const FieldFormPage(),
    availability: (_) => const AvailabilityGridPage(),
    matchComposer: (_) => const MatchComposerPage(),
    matchCenter: (_) => const MatchCenterPage(),
    lineupTactics: (_) => const LineupTacticsBoardPage(),
    stats: (_) => const StatsPage(),
    settings: (_) => const SettingsPage(),
    privacy: (_) => const PrivacyPage(),
  };
}
