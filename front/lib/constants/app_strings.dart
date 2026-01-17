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
  static const String commonPlaceholderDash = '—';
  static const String commonRequiredMarker = '*';
  static const String teamStudioNameRequiredError = 'Team name is required';
  static const String teamStudioNameNotUniqueError = 'Team name must be unique';
  static const String teamStudioDeleteNotAllowed =
      'Team can’t be deleted because it is used in matches.';

  static const String teamsDirectoryTitle = 'Teams Directory';
  static const String teamsDirectoryEmpty = 'No teams created yet.';
  static const String teamsDirectoryNewTeam = '+ New Team';
  static const String teamsDirectoryPlayersCountPrefix = 'Players:';

  static const String fieldsRegistryTitle = 'Fields Registry';
  static const String fieldsRegistryEmpty = 'No fields created yet.';
  static const String fieldsRegistryNewField = '+ Add Field';
  static const String fieldsRegistryUseForMatch = 'Use for match';
  static const String fieldsRegistryOpen = 'Open';
  static const String fieldsRegistryTypePrefix = 'Grass:';

  static const String availabilityTitle = 'Availability';
  static const String availabilityFilterPeriod = 'Period';
  static const String availabilityFilterTeam = 'Team filter';
  static const String availabilityFilterField = 'Field filter';
  static const String availabilityPeriodWeek = 'Week';
  static const String availabilityPeriodMonth = 'Month';
  static const String availabilityTeamDefault = 'Default team';
  static const String availabilityTeamAny = 'Any team';
  static const String availabilityFieldAll = 'All';
  static const String availabilityDayMorning = 'Morning';
  static const String availabilityDayAfternoon = 'Afternoon';
  static const String availabilityDayEvening = 'Evening';
  static const String availabilityMatchPlanned = 'Planned';
  static const String availabilityStatusFinished = 'Finished';
  static const String availabilityResolveConflicts = 'Resolve conflicts';
  static const String availabilityMatchCardFieldLabel = 'Field';
  static String availabilityMatchCardTeams(String teamA, String teamB) =>
      '$teamA vs $teamB';
  static String availabilityMatchCardTime(String date, String time) =>
      '$date, $time';

  static const String matchComposerTitle = 'Match Composer';
  static const String matchComposerFieldPickFromFields = 'Pick from Fields';
  static const String matchComposerTitleLabel = 'Title';
  static const String matchComposerTitleHint = 'Enter name';
  static const String matchComposerDateTimeLabel = 'Date & Time';
  static const String matchComposerDateTimeHint = 'Enter';
  static const String matchComposerFieldLabel = 'Field';
  static const String matchComposerFieldHint = 'Select';
  static const String matchComposerTeamALabel = 'Team A';
  static const String matchComposerTeamBLabel = 'Team B';
  static const String matchComposerTeamHint = 'Enter';
  static const String matchComposerNotesLabel = 'Notes';
  static const String matchComposerNotesHint = 'Enter Notes';
  static const String matchComposerSave = 'Save';
  static const String matchComposerCancel = 'Cancel';
  static const String matchComposerErrorTitleRequired = 'Title is required';
  static const String matchComposerErrorDateTimeRequired =
      'Date & Time is required';
  static const String matchComposerErrorFieldRequired = 'Field is required';
  static const String matchComposerErrorTeamARequired = 'Team A is required';
  static const String matchComposerConflictTitle = 'Time conflict detected';
  static const String matchComposerConflictMessage =
      'This match conflicts with another match for the same team or field.';
  static const String matchComposerConflictSaveAnyway = 'Save anyway';
  static const String matchComposerConflictAdjust = 'Adjust';
  static const String matchComposerDeleteTitle = 'Delete match?';
  static const String matchComposerDeleteMessage =
      'This action can’t be undone.';

  static const String matchCenterTitle = 'Match Center';
  static const String matchCenterRostersPreviewA = 'Rosters preview: A';
  static const String matchCenterRostersPreviewB = 'Rosters preview: B';
  static const String matchCenterTeamATbd = 'Team A';
  static const String matchCenterTeamBTbd = 'Team B / TBD';
  static const String matchCenterActionEditMatch = 'Edit match';
  static const String matchCenterActionJoinTeamB = 'Join Team B';
  static const String matchCenterActionMarkFinished = 'Mark finished';
  static const String matchCenterActionOpenLineup = 'Open Lineup & Tactics';
  static const String matchCenterFinalizeTitle = 'Finalize Match';
  static const String matchCenterFinalizeWinLabel = 'Win';
  static const String matchCenterFinalizeDraw = 'Draw';
  static const String matchCenterFinalizeSave = 'Save';
  static const String matchCenterFinalizeCancel = 'Cancel';
  static const String matchCenterFinalizeWinRequired = 'Select winner';

  static const String fieldFormRequiredMarker = '*';
  static const String fieldFormNameLabel = 'Name';
  static const String fieldFormNameHint = 'Enter name';
  static const String fieldFormAddressLabel = 'Address';
  static const String fieldFormAddressHint = 'Enter Address';
  static const String fieldFormTypeLabel = 'Type';
  static const String fieldFormTypeHint = 'Select Type';
  static const String fieldFormNotesLabel = 'Notes';
  static const String fieldFormNotesHint = 'Enter Notes';
  static const String fieldFormLatLabel = 'Lat';
  static const String fieldFormLonLabel = 'Lon';
  static const String fieldFormLatHint = 'Enter';
  static const String fieldFormLonHint = 'Enter';
  static const String fieldFormPhotoLabel = 'Photo';
  static const String fieldFormPhotoTakePhoto = 'Take photo';
  static const String fieldFormPhotoChooseFromGallery = 'Choose from gallery';
  static const String fieldFormPhotoRemove = 'Remove photo';
  static const String fieldFormDeleteNotAllowed =
      'Field can’t be deleted because it is used in scheduled matches.';
  static const String fieldFormNameRequiredError = 'Name is required';
  static const String fieldFormAddressRequiredError = 'Address is required';

  static const String fieldType5v5 = '5v5';
  static const String fieldType7v7 = '7v7';
  static const String fieldType11v11 = '11v11';
}
