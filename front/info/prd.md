```yaml
app:
  name: FieldCaptain
  platforms: [android]

  routes_file: constants/app_routes.dart
  spacing_tokens: constants/app_spacing.dart
  durations_tokens: constants/app_durations.dart
  assets_constants:
    icons: constants/app_icons.dart
    images: constants/app_images.dart
  strings: app_strings

  codegen:
    strict: true
    unknown_prop: error
    enum_unknown: error
    forbid_inline_numbers: true

  theme:
    single_theme: true
    typography_source: ui/theme/app_fonts.dart
    colors_source: ui/theme/app_colors.dart

  conventions:
    state_suffix: "State"
    cubit_suffix: "Cubit"

screens:
  - page_file: lib/ui/pages/splash_page.dart
    route: /
    page_class: SplashPage
  - page_file: lib/ui/pages/onboarding_page.dart
    route: /onboarding
    page_class: OnboardingPage
  - page_file: lib/ui/pages/hub_page.dart
    route: /hub
    page_class: HubPage
  - page_file: lib/ui/pages/team_studio_page.dart
    route: /team-studio
    page_class: TeamStudioPage
  - page_file: lib/ui/pages/teams_directory_page.dart
    route: /teams
    page_class: TeamsDirectoryPage
  - page_file: lib/ui/pages/fields_registry_page.dart
    route: /fields
    page_class: FieldsRegistryPage
  - page_file: lib/ui/pages/field_form_page.dart
    route: /field-form
    page_class: FieldFormPage
  - page_file: lib/ui/pages/availability_grid_page.dart
    route: /availability
    page_class: AvailabilityGridPage
  - page_file: lib/ui/pages/match_composer_page.dart
    route: /match-composer
    page_class: MatchComposerPage
  - page_file: lib/ui/pages/match_center_page.dart
    route: /match-center
    page_class: MatchCenterPage
  - page_file: lib/ui/pages/lineup_tactics_board_page.dart
    route: /lineup-tactics
    page_class: LineupTacticsBoardPage
  - page_file: lib/ui/pages/stats_page.dart
    route: /stats
    page_class: StatsPage
  - page_file: lib/ui/pages/settings_page.dart
    route: /settings
    page_class: SettingsPage
  - page_file: lib/ui/pages/privacy_page.dart
    route: /privacy
    page_class: PrivacyPage

```

```yaml
screen:
  page_file: lib/ui/pages/splash_page.dart
  strings:
    AppStrings.splashTitle: "FieldCaptain"
    AppStrings.splashTagline: "Plan. Play. Repeat."
  icons: []
  images:
    - AppImages.splashBackground
```


```yaml
screen:
  page_file: lib/ui/pages/onboarding_page.dart
  strings:
    AppStrings.onboardingSkip: "Skip"
    AppStrings.onboardingBack: "Back"
    AppStrings.onboardingNext: "Next"
    AppStrings.onboardingPrivacy: "Privacy"
    AppStrings.onboardingSlide1Title: "Build squads fast"
    AppStrings.onboardingSlide1Subtitle: "Create teams, add players, keep positions."
    AppStrings.onboardingSlide2Title: "Manage local fields"
    AppStrings.onboardingSlide2Subtitle: "Save the pitches you use and reuse them."
    AppStrings.onboardingSlide3Title: "Schedule smarter"
    AppStrings.onboardingSlide3Subtitle: "Plan matches, store results, prepare lineups."
  icons:
    - AppIcons.back
  images:
    - AppImages.onboardingBackground
    - AppImages.onboardingSlideTeamStudio
    - AppImages.onboardingSlideFieldsRegistry
    - AppImages.onboardingSlideHubMatchPlanned
    - AppImages.onboardingSlideHubNoMatchPlanned
    - AppImages.onboardingSlideAvailability

```

```yaml
screen:
  page_file: lib/ui/pages/hub_page.dart
  strings:
    AppStrings.hubAppTitle: "FieldCaptain"
    AppStrings.hubTabMatch: "+ Match"
    AppStrings.hubTabMySquad: "My Squad"
    AppStrings.hubTabFields: "Fields"
    AppStrings.hubSectionNextMatch: "Next Match"
    AppStrings.hubChipStatus: "Status"
    AppStrings.hubActionOpen: "Open"
    AppStrings.hubEmptyNoMatchPlanned: "No match planned."
    AppStrings.hubCtaAddMatch: "+ Match"
    AppStrings.hubSectionMySquad: "My Squad"
    AppStrings.hubLabelTeamName: "Team name"
    AppStrings.hubLabelPlayersCount: "Players: N"
    AppStrings.hubActionLineup: "Lineup"
    AppStrings.hubSectionFieldsSnapshot: "Fields Snapshot"
    AppStrings.hubLinkAllFields: "All Fields"
  icons:
    - AppIcons.settings
    - AppIcons.more
    - AppIcons.add
    - AppIcons.chevronRight
  images:
    - AppImages.hubNextMatchCardBackground
    - AppImages.hubNoMatchPlannedCardBackground
    - AppImages.hubMySquadCardBackground
    - AppImages.hubFieldSnapshotCardBackground
```

```yaml
screen:
  page_file: lib/ui/pages/team_studio_page.dart
  strings:
    AppStrings.teamStudioTitle: "Team Studio"
    AppStrings.teamStudioTabProfile: "Profile"
    AppStrings.teamStudioTabRoster: "Roster"
    AppStrings.teamStudioTeamNameLabel: "Team name"
    AppStrings.teamStudioTeamNameRequiredMarker: "*"
    AppStrings.teamStudioTeamNameHint: "Enter name"
    AppStrings.teamStudioBadgeIconLabel: "Badge icon"
    AppStrings.teamStudioHomeColorsLabel: "Home colors"
    AppStrings.teamStudioAwayColorsLabel: "Away colors"
    AppStrings.teamStudioSave: "Save"
    AppStrings.teamStudioMenuDeleteTeam: "Delete team"
    AppStrings.teamStudioMenuSetAsDefault: "Set as default"
    AppStrings.teamStudioPlayerPositionLabel: "Position:"
    AppStrings.teamStudioPlayerNumberLabel: "#:"
  icons:
    - AppIcons.back
    - AppIcons.more
    - AppIcons.edit
    - AppIcons.delete
    - AppIcons.add
    - AppIcons.check
  images:
    - AppImages.teamStudioBackground
    - AppImages.teamBadgeIcons
    - AppImages.teamKitHomePreview
    - AppImages.teamKitAwayPreview

```

```yaml
screen:
  page_file: lib/ui/pages/teams_directory_page.dart
  strings:
    AppStrings.teamsDirectoryTitle: "Teams Directory"
    AppStrings.teamsDirectoryLabelName: "Name"
    AppStrings.teamsDirectoryLabelPlayersCount: "Players: N"
    AppStrings.teamsDirectoryActionOpen: "Open"
  icons:
    - AppIcons.back
    - AppIcons.add
    - AppIcons.more
  images:
    - AppImages.teamBadgeIcons
```

```yaml
screen:
  - page_file: lib/ui/pages/fields_registry_page.dart
    strings:
      AppStrings.fieldsRegistryTitle: "Fields Registry"
      AppStrings.fieldsRegistrySectionSnapshot: "Fields Snapshot"
      AppStrings.fieldsRegistryFieldNamePlaceholder: "Park Field"
      AppStrings.fieldsRegistryGrassFormat: "Grass: {format}"
      AppStrings.fieldsRegistryAddressPlaceholder: "Address"
      AppStrings.fieldsRegistryActionUseForMatch: "Use for match"
      AppStrings.fieldsRegistryActionOpen: "Open"
    icons:
      - AppIcons.back
      - AppIcons.add
    images:
      - AppImages.fieldsRegistryCardBackground
  - page_file: lib/ui/pages/field_form_page.dart
    strings:
      AppStrings.fieldFormTitle: "Fields Registry"
      AppStrings.fieldFormNameLabel: "Name"
      AppStrings.fieldFormRequiredMarker: "*"
      AppStrings.fieldFormNameHint: "Enter name"
      AppStrings.fieldFormAddressLabel: "Address"
      AppStrings.fieldFormAddressHint: "Enter Address"
      AppStrings.fieldFormTypeLabel: "Type"
      AppStrings.fieldFormTypeHint: "Select Type"
      AppStrings.fieldFormNotesLabel: "Notes"
      AppStrings.fieldFormNotesHint: "Enter Notes"
      AppStrings.fieldFormLatLabel: "Lat"
      AppStrings.fieldFormLonLabel: "Lon"
      AppStrings.fieldFormCoordinateHint: "Enter"
      AppStrings.fieldFormPhotoLabel: "Photo"
      AppStrings.fieldFormShowOnMap: "Show on map"
      AppStrings.fieldFormSave: "Save"
    icons:
      - AppIcons.back
      - AppIcons.edit
      - AppIcons.chevronDown
      - AppIcons.add
    images:
      - AppImages.fieldFormPhotoPlaceholder
```

```yaml
screen:
  page_file: lib/ui/pages/availability_grid_page.dart
  strings:
    AppStrings.availabilityTitle: "Availability"
    AppStrings.availabilityFilterPeriod: "Period"
    AppStrings.availabilityFilterTeam: "Team filter"
    AppStrings.availabilityFilterField: "Field filter"
    AppStrings.availabilityPeriodWeek: "Week"
    AppStrings.availabilityPeriodMonth: "Month"
    AppStrings.availabilityTeamDefault: "Default team"
    AppStrings.availabilityTeamAny: "Any team"
    AppStrings.availabilityFieldAll: "All"
    AppStrings.availabilityFieldTeam: "Team"
    AppStrings.availabilityDayMorning: "Morning"
    AppStrings.availabilityDayAfternoon: "Afternoon"
    AppStrings.availabilityDayEvening: "Evening"
    AppStrings.availabilityMatchPlanned: "Planned"
    AppStrings.availabilityStatusFinished: "Finished"
    AppStrings.availabilityMatchCardTimeFormat: "{month} {day}, {time}"
    AppStrings.availabilityMatchCardTeamsFormat: "{teamA} vs {teamB}"
    AppStrings.availabilityMatchCardFieldLabel: "Field"
  icons:
    - AppIcons.back
    - AppIcons.chevronDown
    - AppIcons.chevronLeft
    - AppIcons.chevronRight
    - AppIcons.check
  images: []
```

```yaml
screen:
  page_file: lib/ui/pages/match_composer_page.dart
  strings:
    AppStrings.matchComposerTitle: "Match Composer"
    AppStrings.matchComposerTitleLabel: "Title"
    AppStrings.matchComposerRequiredMarker: "*"
    AppStrings.matchComposerTitleHint: "Enter name"
    AppStrings.matchComposerDateTimeLabel: "Date & Time"
    AppStrings.matchComposerDateTimeHint: "Enter"
    AppStrings.matchComposerFieldLabel: "Field"
    AppStrings.matchComposerFieldHint: "Select"
    AppStrings.matchComposerPickFromFields: "Pick from Fields"
    AppStrings.matchComposerTeamALabel: "Team A"
    AppStrings.matchComposerTeamBLabel: "Team B"
    AppStrings.matchComposerTeamHint: "Enter"
    AppStrings.matchComposerNotesLabel: "Notes"
    AppStrings.matchComposerNotesHint: "Enter Notes"
    AppStrings.matchComposerSave: "Save"
    AppStrings.matchComposerCancel: "Cancel"
  icons:
    - AppIcons.back
    - AppIcons.edit
    - AppIcons.delete
    - AppIcons.calendar
    - AppIcons.chevronDown
    - AppIcons.add
  images: []
```

```yaml
screen:
  page_file: lib/ui/pages/match_center_page.dart
  strings:
    AppStrings.matchCenterTitle: "Match Center"
    AppStrings.matchCenterHeaderTeamsFormat: "{teamA} vs {teamB}/{tbd}"
    AppStrings.matchCenterHeaderMetaFormat: "{dateTime} • {field} • {status}"
    AppStrings.matchCenterSectionRostersPreviewA: "Rosters  preview: A"
    AppStrings.matchCenterSectionRostersPreviewB: "Rosters  preview: B"
    AppStrings.matchCenterActionEditMatch: "Edit match"
    AppStrings.matchCenterActionJoinTeamB: "Join Team B"
    AppStrings.matchCenterActionMarkFinished: "Mark finished"
    AppStrings.matchCenterSectionFinalizeMatch: "Finalize Match"
    AppStrings.matchCenterWinLabel: "Win"
    AppStrings.matchCenterWinnerTeamA: "Team A"
    AppStrings.matchCenterWinnerTeamB: "Team B"
    AppStrings.matchCenterWinnerDraw: "Draw"
    AppStrings.matchCenterSave: "Save"
    AppStrings.matchCenterCancel: "Cancel"
  icons:
    - AppIcons.back
    - AppIcons.more
    - AppIcons.check
  images:
    - AppImages.matchCenterHeaderBackground
```

```yaml
screen:
  page_file: lib/ui/pages/stats_page.dart
  strings:
    AppStrings.statsTitle: "Stats"
    AppStrings.statsTabTeams: "Teams"
    AppStrings.statsTabMatches: "Matches"
    AppStrings.statsTabFields: "Fields"
    AppStrings.statsTeamNameLabel: "Name"
    AppStrings.statsTeamPlayersLabel: "Players: N"
    AppStrings.statsTeamSizesSummary: "8 / 5 / 5"
    AppStrings.statsTeamAvgRatingSize: "Avg rt. sz: 11.7"
    AppStrings.statsMatchesCreated: "Created"
    AppStrings.statsMatchesScheduled: "Scheduled"
    AppStrings.statsMatchesFinished: "Finished"
    AppStrings.statsFieldMetaFormat: "{dateTime} • {field} • {status}"
  icons:
    - AppIcons.back
    - AppIcons.chevronRight
  images:
    - AppImages.teamBadgeIcons
```

```yaml
screen:
  page_file: lib/ui/pages/lineup_tactics_board_page.dart
  strings:
    AppStrings.lineupBoardTitle: "Lineup & Tactics Board"
    AppStrings.lineupBoardHeaderTitleFormat: "{teamA} vs {teamBOrTbd} — Match Board"
    AppStrings.lineupBoardHeaderMetaFormat: "Kick-off: {dateTime} · Field: {fieldName}"
    AppStrings.lineupBoardSave: "Save"
    AppStrings.lineupBoardBack: "Back"
    AppStrings.lineupBoardTabLineup: "Lineup"
    AppStrings.lineupBoardTabTactics: "Tactics"
    AppStrings.lineupBoardTabLogistics: "Logistics"
    AppStrings.lineupBoardDiscardDialogTitle: "Discard changes?"
    AppStrings.lineupBoardDiscardKeepEditing: "Keep editing"
    AppStrings.lineupBoardDiscardConfirm: "Discard"

    AppStrings.lineupBoardTeamSwitcherTitle: "Team Switcher"
    AppStrings.lineupBoardFormationLabel: "Formation"
    AppStrings.lineupBoardFormationHint: "Select formation"
    AppStrings.lineupBoardFormationHelper: "Slots update with formation"
    AppStrings.lineupBoardSearchPlayersHint: "Search players..."
    AppStrings.lineupBoardAvailableLabel: "Available"
    AppStrings.lineupBoardAutoArrange: "Auto-arrange"
    AppStrings.lineupBoardClearLineup: "Clear lineup"

    AppStrings.lineupBoardFormation442: "4-4-2"
    AppStrings.lineupBoardFormation433: "4-3-3"
    AppStrings.lineupBoardFormation352: "3-5-2"
    AppStrings.lineupBoardFormation532: "5-3-2"

    AppStrings.lineupBoardTacticsFilterPressing: "Pressing"
    AppStrings.lineupBoardTacticsFilterWidth: "Width"
    AppStrings.lineupBoardTacticsFilterBuildUp: "Build-up"
    AppStrings.lineupBoardSetPiecesNotesTitle: "Set Pieces Notes"
    AppStrings.lineupBoardSetPiecesCorners: "Corners"
    AppStrings.lineupBoardSetPiecesFreeKicks: "Free-kicks"
    AppStrings.lineupBoardEnterNotesHint: "Enter Notes"
    AppStrings.lineupBoardKitClashDetectorTitle: "Kit Clash Detector"
    AppStrings.lineupBoardTeamAKitLabel: "Team A kit"
    AppStrings.lineupBoardTeamBKitLabel: "Team B kit"
    AppStrings.lineupBoardQuickMatchNotesTitle: "Quick Match Notes"
    AppStrings.lineupBoardQuickMatchKeyMatchups: "Key matchups"
    AppStrings.lineupBoardQuickMatchDoDontBullets: "Do / Don’t bullets"

    AppStrings.lineupBoardPressingLow: "Low"
    AppStrings.lineupBoardPressingMedium: "Medium"
    AppStrings.lineupBoardPressingHighSegmented: "High (segmented)"
    AppStrings.lineupBoardWidthNarrow: "Narrow"
    AppStrings.lineupBoardWidthBalanced: "Balanced"
    AppStrings.lineupBoardWidthWide: "Wide"
    AppStrings.lineupBoardBuildUpDirect: "Direct"
    AppStrings.lineupBoardBuildUpMixed: "Mixed"
    AppStrings.lineupBoardBuildUpShort: "Short"

    AppStrings.lineupBoardLogisticsTeamA: "Team A"
    AppStrings.lineupBoardLogisticsTeamB: "Team B"
    AppStrings.lineupBoardLogisticsPlayerNamePlaceholder: "Name"
    AppStrings.lineupBoardLogisticsComing: "Coming"
    AppStrings.lineupBoardLogisticsPosLabel: "POS"
    AppStrings.lineupBoardLogisticsConfirmedSummaryFormat: "Confirmed: {confirmed} / Total: {total}"

    AppStrings.lineupBoardFeeSplitTitle: "Fee Split"
    AppStrings.lineupBoardPitchFeeTotalLabel: "Pitch fee (total)"
    AppStrings.lineupBoardSplitLabel: "Split"
    AppStrings.lineupBoardSplitConfirmedOnly: "confirmed only"
    AppStrings.lineupBoardSplitAllRoster: "All roster"
    AppStrings.lineupBoardOutputLabel: "Output:"
    AppStrings.lineupBoardOutputPerPlayerFormat: "Per player: {amount}"
    AppStrings.lineupBoardHelperCalculation: "This is a helper calculation."

    AppStrings.lineupBoardMatchSheetNotesTitle: "Match Sheet Notes"
    AppStrings.lineupBoardMeetTimeHint: "Meet time"
    AppStrings.lineupBoardWhatToBringTitle: "What to bring"
    AppStrings.lineupBoardBringCash: "Cash"
    AppStrings.lineupBoardBringBibs: "Bibs"
    AppStrings.lineupBoardBringBall: "Ball"
    AppStrings.lineupBoardBringWater: "Water"
    AppStrings.lineupBoardCrewNotesLabel: "Crew notes"
    AppStrings.lineupBoardCopySummary: "Copy summary"

  icons:
    - AppIcons.back
    - AppIcons.more
    - AppIcons.chevronDown
    - AppIcons.search
    - AppIcons.calendar
    - AppIcons.chevronRight
    - AppIcons.check

  images:
    - AppImages.lineupBoardPitch
    - AppImages.lineupBoardTeamAKit
    - AppImages.lineupBoardTeamBKit
```

```yaml
screen:
  page_file: lib/ui/pages/settings_page.dart
  strings:
    AppStrings.settingsTitle: "Settings"
    AppStrings.settingsSectionDefaults: "Defaults:"
    AppStrings.settingsDefaultTeam: "Default team"
    AppStrings.settingsSectionNotifications: "Notifications:"
    AppStrings.settingsLocalMatchReminders: "Local match reminders"
    AppStrings.settingsSectionAbout: "About:"
    AppStrings.settingsVersion: "Version"
    AppStrings.settingsPrivacy: "Privacy"
    AppStrings.settingsClearAllData: "Clear all data"
  icons:
    - AppIcons.back
    - AppIcons.chevronRight
  images: []
```