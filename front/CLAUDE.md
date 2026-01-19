# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Analyze code (Very Good Analysis - strict)
flutter analyze

# Build debug APK
flutter build apk --debug

# Generate launcher icons
dart run flutter_launcher_icons

# Regenerate Drift database code after schema changes
dart run build_runner build --delete-conflicting-outputs

# Full clean rebuild (when Kotlin/Flutter changes aren't reflected)
cd android && ./gradlew clean && cd .. && flutter clean && flutter pub get
```

## Architecture Overview

This is **FieldCaptain**, an offline-first Flutter app for organizing amateur football matches. Android-only, portrait-locked.

### Layer Structure

```
lib/
├── constants/       # Static config, routes, strings, sizes, colors
├── core/            # Environment config (endpoints.dart, env.dart)
├── data/
│   ├── local/
│   │   ├── database/   # Drift SQLite (schema/, dao/)
│   │   └── prefs_store.dart
│   ├── models/      # DTOs and custom models
│   └── repositories/ # Data access layer (7 repos)
├── providers/       # ChangeNotifier state management (7 providers)
├── services/        # NotificationService (WorkManager)
└── ui/
    ├── pages/       # 13 main screens
    ├── widgets/     # Reusable UI components
    └── theme/       # Material 3 dark theme
```

### State Management Pattern

**Provider + Repository + Streams**

1. **Repositories** wrap Drift DAOs and expose `Stream<List<T>>` via `watch*()` methods
2. **Providers** extend `ChangeNotifier`, subscribe to repository streams in constructor
3. **UI** uses `context.watch<Provider>()` for reactive rebuilds

Example flow:
```dart
// Repository exposes stream
Stream<List<Team>> watchTeams() => _dao.watchAll();

// Provider subscribes and notifies
_repository.watchTeams().listen((value) {
  _teams = value;
  notifyListeners();
});

// UI reads from provider
context.watch<TeamsProvider>().teams
```

### Dependency Injection

All dependencies are created in `app.dart` via `_AppDependencies.create()`:
- `PrefsStore` (SharedPreferences wrapper)
- `AppDatabase` (Drift)
- 7 repositories (injected with database/prefs)
- 7 providers (injected with repositories)

### Database (Drift)

- **File:** `lib/data/local/database/app_database.dart`
- **Schema version:** 6
- **Tables:** Teams, Players, Fields, Matches, Lineups, LineupSlots, Attendance, MatchLogistics, Tactics, DoDontItems, SettingsEntries
- **DAOs:** TeamsDao, FieldsDao, MatchesDao, LineupDao, TacticsDao, SettingsDao

After modifying schema files in `database/schema/`:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Navigation

Named routes defined in `constants/app_routes.dart`:
- `/` - SplashPage
- `/onboarding` - OnboardingPage
- `/hub` - HubPage (main dashboard)
- `/team-studio` - TeamStudioPage
- `/match-center` - MatchCenterPage
- `/lineup-tactics` - LineupTacticsBoardPage (largest screen)
- etc.

### Background Notifications

Uses **WorkManager** (not exact alarms) for match reminders:
- `@pragma('vm:entry-point') callbackDispatcher()` in notification_service.dart
- Periodic task checks every hour at :45 minutes
- 15-minute reminder lead time with ±7 minute tolerance window
- Tracks notified matches in SharedPreferences to avoid duplicates

### Key Files

| File | Purpose |
|------|---------|
| `app.dart` | Dependency injection, MultiProvider setup |
| `constants/app_routes.dart` | All route definitions |
| `constants/app_strings.dart` | All UI strings (localization) |
| `data/local/database/app_database.dart` | Drift database definition |
| `services/notifications/notification_service.dart` | WorkManager background tasks |
| `ui/pages/lineup_tactics_board_page.dart` | Most complex screen (lineup editor) |

## Naming Restrictions

Avoid these words in code and strings (Google Play compliance):
- 'casino', 'bets', 'slots', 'money', 'gambling', 'jackpot', 'wager', 'payout', 'roulette', 'poker', 'blackjack', 'bingo', 'lottery', 'scratch', 'prize', 'win', 'spin'

## Build Configuration

The parent `back/config.yaml` provides BuildConfig constants parsed by `android/app/build.gradle.kts`. Access via platform channels in Flutter, never hardcode.
