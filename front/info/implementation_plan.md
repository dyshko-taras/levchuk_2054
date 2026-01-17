# Implementation Plan — FieldCaptain (Flutter / Android)

Цей файл — робочий план реалізації додатку за вимогами з `front/info/` (PRD + Technical Spec + Visual Style + Guidelines). Під час реалізації я буду відмічати виконані пункти, змінюючи чекбокси.

> Примітка по репозиторію: Flutter-проєкт знаходиться в папці `front/`, тому всі шляхи нижче — від кореня репозиторію (наприклад `front/lib/...`, `front/pubspec.yaml`).

## Незаперечні обмеження

- `main()` — не змінювати (допускається лише доповнення).
- Папку `assets/` не чіпати (вважаємо, що всі потрібні ресурси там вже є).
- Пріоритет вимог: `front/info/prd.md` → `front/info/implementation_plan.md` → `front/info/guidelines.md`.
- Архітектура: `Provider` + `ChangeNotifier`, без “магічних” чисел для відступів/радіусів/тривалостей, без “сирих” шляхів до ресурсів (тільки `AppIcons`/`AppImages`), без хардкоду строк (тільки `AppStrings`).

## Фази (порядок виконання)

### - [x] Phase 0 — Підготовка та каркас проєкту (структура/залежності)

- [x] Звірити/підтвердити структуру `lib/` згідно `front/info/guidelines.md`.
- [x] Додати/звірити залежності в `pubspec.yaml` (provider, drift, shared_preferences, flutter_svg, etc. з `front/info/guidelines.md`).
- [x] Підключити codegen (де потрібно): `build_runner`, `json_serializable`, `drift_dev` (без “зайвих” генерацій/рефакторів).
- [x] Прогнати `flutter pub get` та `flutter analyze` (без помилок).

#### Файли (мінімальний каркас, якщо їх ще немає)
- [x] `front/lib/main.dart` (не змінювати `main()`, лише доповнення якщо треба для init)
- [x] `front/lib/app.dart`
- [x] `front/lib/core/env.dart`
- [x] `front/lib/core/endpoints.dart`

### - [x] Phase 1 — Constants (tokens/assets/strings/routes) + Theme (M3) + App shell

#### Constants — контракт (без хардкоду в UI)
- [x] `front/lib/constants/app_config.dart` (app-level конфіги: мінімум)
- [x] `front/lib/constants/app_routes.dart` (маршрути зі списку екранів у `front/info/prd.md`)
- [x] `front/lib/constants/app_strings.dart` (усі статичні тексти тільки тут; ключі з `front/info/prd.md`)
- [x] `front/lib/constants/app_icons.dart` (тільки мапінг на assets; використовувати з `flutter_svg`)
- [x] `front/lib/constants/app_images.dart` (тільки мапінг на assets; `Image.asset`)
- [x] `front/lib/constants/app_spacing.dart` (AppSpacing/Gaps/Insets/NumSpaceExtension — без “магічних” чисел в UI)
- [x] `front/lib/constants/app_radius.dart` (AppRadius — pill/cards тощо)
- [x] `front/lib/constants/app_sizes.dart` (Sizes — компонентні розміри, де потрібно)
- [x] `front/lib/constants/app_durations.dart` (AppDurations — splash min 2s + анімації/UX)

#### Theme — єдине джерело стилів
- [x] `front/lib/ui/theme/app_colors.dart` (кольори з `front/info/visual_style.md`)
- [x] `front/lib/ui/theme/app_fonts.dart` (OpenSans Regular/SemiBold; зв’язок з pubspec fonts)
- [x] `front/lib/ui/theme/app_theme.dart` (ThemeData, Material 3, colorScheme, textTheme)

#### App shell
- [x] `front/lib/app.dart`: `MultiProvider` (поки провайдери можна підключати порожнім списком) + `MaterialApp` + `routes: AppRoutes.routes` + `theme: appTheme`
- [x] Підключений variable font `OpenSans-VariableFont_wdth,wght.ttf` у `front/pubspec.yaml`.

### - [x] Phase 2 — Local storage: Drift DB + Prefs + Models

#### Файли БД/Prefs
- [x] `front/lib/data/local/prefs_store.dart` (first launch, local reminders enabled, default team id тощо)
- [x] `front/lib/data/local/database/app_database.dart`
- [x] `front/lib/data/local/database/schema/` (таблиці/entitites для MVP)
- [x] `front/lib/data/local/database/dao/` (typed queries)

#### Models (за потреби для UI/DTO, без вигадування полів)
- [ ] `front/lib/data/models/` (моделі, які реально потрібні; якщо все локально — можна обійтись drift-типами)

#### Мінімальні домени MVP у сховищі
- [ ] Teams + Players
- [ ] Fields
- [ ] Matches/Fixtures (планування + статус)
- [ ] Lineup (formation + slots) + Attendance
- [ ] Tactics + Notes + Do/Don’t
- [ ] Settings (default team, reminders, first-launch)

### - [x] Phase 3 — Repositories (Data access layer)

- [x] `front/lib/data/repositories/settings_repository.dart`
- [x] `front/lib/data/repositories/teams_repository.dart`
- [x] `front/lib/data/repositories/fields_repository.dart`
- [x] `front/lib/data/repositories/matches_repository.dart`
- [x] `front/lib/data/repositories/lineup_repository.dart`
- [x] `front/lib/data/repositories/tactics_repository.dart`
- [x] `front/lib/data/repositories/stats_repository.dart` (поки stub; реалізуємо коли Stats будуть чітко визначені у спеці)

### - [x] Phase 4 — Providers (Business logic layer)

- [x] `front/lib/providers/settings_provider.dart`
- [x] `front/lib/providers/teams_provider.dart`
- [x] `front/lib/providers/fields_provider.dart`
- [x] `front/lib/providers/matches_provider.dart`
- [x] `front/lib/providers/lineup_provider.dart`
- [x] `front/lib/providers/tactics_provider.dart`
- [x] `front/lib/providers/stats_provider.dart` (поки stub; розширимо коли Stats будуть чітко визначені у спеці)

### - [x] Phase 5 — Screen: Splash (`/`)

- [x] `front/lib/ui/pages/splash_page.dart` (min 2s + init DB/prefs → redirect на onboarding/hub)
- [x] UI: background image + dark overlay, centered title/tagline, loader bottom-center (без інтеракцій)

### - [x] Phase 6 — Screen: Onboarding (`/onboarding`)

- [x] `front/lib/ui/pages/onboarding_page.dart` (3 слайди, Back/Skip, dots, Next, Privacy на останньому слайді)
- [x] Reusable buttons: `front/lib/ui/widgets/buttons/app_buttons.dart`

### - [x] Phase 7 — Screen: Hub (`/hub`)

- [x] `front/lib/ui/pages/hub_page.dart` (quick bar, next match card, my squad snapshot, fields snapshot)
- [x] `front/lib/ui/widgets/navigation/quick_bar.dart` (2–3 items: full width, без scroll; 4+: scroll)
- [x] `front/lib/ui/widgets/hub/hub_cards.dart` (hub cards)

### - [x] Phase 8 — Screen: Team Studio (`/team-studio`)

- [x] `front/lib/ui/pages/team_studio_page.dart` (Profile/Roster, Save, More menu: delete/set default)
- [x] Badge picker: `front/lib/ui/widgets/team_studio/badge_picker.dart`
- [x] Kit SVG preview (2 colors): `front/lib/ui/widgets/team_studio/kit_preview.dart`
- [x] Color picker row: `front/lib/ui/widgets/team_studio/preset_color_row.dart`

### - [x] Phase 9 — Screen: Teams Directory (`/teams`)

- [x] `front/lib/ui/pages/teams_directory_page.dart` (header Back/+; список команд; Open; More: set default/delete; empty state)

### - [x] Phase 10 — Screen: Fields Registry (`/fields`)

- [x] `front/lib/ui/pages/fields_registry_page.dart` (список полів, картки, переходи)
- [x] `front/lib/ui/widgets/fields/field_registry_card.dart` (field card)

### - [x] Phase 11 — Screen: Field Form (`/field-form`)

- [x] `front/lib/ui/pages/field_form_page.dart` (create/edit, валідації, save, delete rules)
- [x] Delete constraint: `planned` matches prevent delete (provider + DAO)

### - [x] Phase 12 — Screen: Availability Grid (`/availability`)

- [x] `front/lib/ui/pages/availability_grid_page.dart` (календар + тайм-слоти, фільтри, конфлікти MVP)
- [x] Використано `table_calendar` для календаря

### - [x] Phase 13 — Screen: Match Composer (`/match-composer`)

- [x] `front/lib/ui/pages/match_composer_page.dart` (create/edit, prefill, pickers, conflict warning, save/delete)
- [x] `front/lib/data/local/database/schema/matches.dart` (додано `title`)

### - [x] Phase 14 — Screen: Match Center (`/match-center`)

- [x] `front/lib/ui/pages/match_center_page.dart` (summary, roster preview, actions, finalize match)
- [x] `front/lib/data/local/database/schema/matches.dart` (result/score fields)

### - [ ] Phase 15 — Screen: Lineup & Tactics Board (`/lineup-tactics`)

- [ ] `front/lib/ui/pages/lineup_tactics_board_page.dart` (3 tabs: Lineup/Tactics/Logistics)
- [ ] Tab Lineup: formation, slots, auto-arrange, clear, soft warnings (save дозволено)
- [ ] Tab Tactics: pressing/width/build-up, set pieces notes, quick notes, do/don’t з чекбоксами
- [ ] Tab Logistics: attendance, fee split, match sheet notes, copy summary
- [ ] Kit clash detector (MVP): автоматично, без UI

### - [ ] Phase 16 — Screen: Stats (`/stats`)

- [ ] `front/lib/ui/pages/stats_page.dart` (тільки те, що прямо визначено у `front/info/technical_spec.md`)

### - [ ] Phase 17 — Screen: Settings (`/settings`)

- [ ] `front/lib/ui/pages/settings_page.dart` (default team, reminders toggle, version, privacy, clear all data + confirm)

### - [x] Phase 18 — Privacy (method placeholder)

- [x] `front/lib/ui/privacy/privacy_actions.dart` (TODO: статичний privacy текст як модал, без зовнішніх лінків)

### - [ ] Phase 19 — Дизайн-полірування, UX та перевірка відповідності (по скрінах)

- [ ] Піксель-матчинг UI по скрінах, які ти будеш кидати (окремо для кожного екрану).
- [ ] Перевірити відсутність хардкоду строк/відступів/радіусів/ресурсів (контракти з `front/info/guidelines.md`).
- [ ] Тестові сценарії “happy path” та edge cases по ключових флоу: first launch, створення команди/поля/матчу, lineup/tactics/logistics, wipe data.

## Артефакти (коли будемо реалізовувати)

- Скрін/фрейм → я фіксую: (1) компоненти, (2) токени, (3) інтеракції/стани, (4) потрібні ключі `AppStrings`, (5) потрібні `AppIcons`/`AppImages`.
- Якщо якийсь UI/логіка не визначені у `front/info/technical_spec.md`, я зупиняюсь і уточнюю у тебе, не вигадую.
