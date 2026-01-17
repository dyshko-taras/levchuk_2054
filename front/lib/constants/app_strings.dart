class AppStrings {
  const AppStrings._();

  static const String appName = 'FieldCaptain';

  static const String splashTitle = 'FieldCaptain';
  static const String splashTagline = 'Plan. Play. Repeat.';

  static const String onboardingSkip = 'Skip';
  static const String onboardingBack = 'Back';
  static const String onboardingNext = 'Next';
  static const String onboardingPrivacy = 'Privacy';
  static const String onboardingSlide1Title = 'Build squads fast';
  static const String onboardingSlide1Subtitle =
      'Create teams, add players, keep positions.';
  static const String onboardingSlide2Title = 'Manage local fields';
  static const String onboardingSlide2Subtitle =
      'Save the pitches you use and reuse them.';
  static const String onboardingSlide3Title = 'Schedule smarter';
  static const String onboardingSlide3Subtitle =
      'Plan matches, store results, prepare lineups.';

  static const String hubAppTitle = 'FieldCaptain';
  static const String hubTabMatch = '+ Match';
  static const String hubTabMySquad = 'My Squad';
  static const String hubTabFields = 'Fields';
  static const String hubTabStats = 'Stats';
  static const String hubTabAvailability = 'Availability';

  static const String hubSectionNextMatch = 'Next Match';
  static const String hubChipStatus = 'Status';
  static const String hubActionOpen = 'Open';
  static const String hubCtaAddMatch = '+ Match';
  static const String hubEmptyNoMatchPlanned = 'No match planned.';

  static const String hubSectionMySquad = 'My Squad';
  static const String hubLabelTeamName = 'Team name';
  static String hubLabelPlayersCount(int count) => 'Players: $count';
  static const String hubActionLineup = 'Lineup';

  static const String hubSectionFieldsSnapshot = 'Fields Snapshot';
  static const String hubLinkAllFields = 'All Fields';

  static const String settingsTitle = 'Settings';

  static const String teamStudioTitle = 'Team Studio';
  static const String teamStudioTabProfile = 'Profile';
  static const String teamStudioTabRoster = 'Roster';
  static const String teamStudioTeamNameLabel = 'Team name';
  static const String teamStudioTeamNameRequiredMarker = '*';
  static const String teamStudioTeamNameHint = 'Enter name';
  static const String teamStudioBadgeIconLabel = 'Badge icon';
  static const String teamStudioHomeColorsLabel = 'Home colors';
  static const String teamStudioAwayColorsLabel = 'Away colors';
  static const String teamStudioSave = 'Save';
  static const String teamStudioMenuDeleteTeam = 'Delete team';
  static const String teamStudioMenuSetAsDefault = 'Set as default';
  static const String teamStudioRosterAddPlayer = '+ Add Player';
  static const String teamStudioPlayerDialogTitle = 'Add player';
  static const String teamStudioPlayerNameLabel = 'Name';
  static const String teamStudioPlayerNameHint = 'Enter name';
  static const String teamStudioPlayerPositionLabel = 'Position';
  static const String teamStudioPlayerNumberLabel = '#';
  static const String commonCancel = 'Cancel';
  static const String commonAdd = 'Add';
  static const String commonSave = 'Save';
  static const String commonDelete = 'Delete';
  static const String commonOk = 'OK';
  static const String teamStudioNameRequiredError = 'Team name is required';
  static const String teamStudioNameNotUniqueError = 'Team name must be unique';
  static const String teamStudioDeleteNotAllowed =
      'Team can’t be deleted because it is used in matches.';

  static const String teamsDirectoryTitle = 'Teams Directory';
  static const String teamsDirectoryEmpty = 'No teams created yet.';
  static const String teamsDirectoryNewTeam = '+ New Team';
  static const String teamsDirectoryPlayersCountPrefix = 'Players:';
}
