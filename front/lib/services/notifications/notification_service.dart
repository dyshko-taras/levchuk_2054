import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';

const String _matchReminderTask = 'match_reminder_check';
const String _matchReminderWorkName = 'match_reminder_work';
const String _notifiedMatchesKey = 'match_reminder_notified_matches';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task != _matchReminderTask) return Future.value(true);

    final notifications = FlutterLocalNotificationsPlugin();
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await notifications.initialize(initSettings);

    final db = AppDatabase();
    try {
      final now = DateTime.now();
      const reminderLead = Duration(minutes: 15);
      const tolerance = Duration(minutes: 7);

      final target = now.add(reminderLead);
      final windowEnd = target.add(tolerance);
      final windowStart = target.subtract(tolerance);

      final planned = await (db.select(db.matches)
            ..where(
              (m) =>
                  m.status.equals('planned') &
                  m.startAt.isBiggerOrEqualValue(windowStart) &
                  m.startAt.isSmallerOrEqualValue(windowEnd),
            ))
          .get();

      if (planned.isEmpty) return Future.value(true);

      final prefs = await SharedPreferences.getInstance();
      final notifiedRaw = prefs.getString(_notifiedMatchesKey);
      final notified = <String, int>{};
      if (notifiedRaw != null && notifiedRaw.trim().isNotEmpty) {
        final decoded = jsonDecode(notifiedRaw);
        if (decoded is Map) {
          for (final entry in decoded.entries) {
            final key = entry.key?.toString();
            final value = entry.value;
            if (key == null || value is! int) continue;
            notified[key] = value;
          }
        }
      }

      for (final match in planned) {
        final key = '${match.id}';
        final startAtMs = match.startAt.millisecondsSinceEpoch;
        if (notified[key] == startAtMs) continue;

        const details = NotificationDetails(
          android: AndroidNotificationDetails(
            'match_reminders',
            'Match reminders',
            channelDescription: 'Local match reminders',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
        );

        await notifications.show(
          match.id,
          '⚽ ${match.title}',
          AppStrings.settingsRowLocalMatchReminders,
          details,
        );

        notified[key] = startAtMs;
      }

      await prefs.setString(_notifiedMatchesKey, jsonEncode(notified));
      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    } finally {
      await db.close();
    }
  });
}

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;
  static const MethodChannel _settingsChannel = MethodChannel(
    'field_captain/app_settings',
  );

  static Future<void> initialize() async {
    if (_initialized) return;

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _notifications.initialize(initSettings);

    await Workmanager().initialize(callbackDispatcher);

    _initialized = true;
  }

  static Future<bool> areNotificationsEnabled() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    return await android?.areNotificationsEnabled() ?? true;
  }

  static Future<void> requestPermissionsIfNeeded() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  static Future<bool> ensureNotificationPermission() async {
    final enabled = await areNotificationsEnabled();
    if (enabled) return true;

    await requestPermissionsIfNeeded();
    return await areNotificationsEnabled();
  }

  static Future<void> openAppNotificationSettings() async {
    try {
      await _settingsChannel.invokeMethod<void>('openNotificationSettings');
    } catch (_) {}
  }

  static Future<void> setMatchRemindersEnabled(bool enabled) async {
    if (enabled) {
      final now = DateTime.now();
      var firstRun = DateTime(now.year, now.month, now.day, now.hour, 45);
      if (!firstRun.isAfter(now)) {
        firstRun = firstRun.add(const Duration(hours: 1));
      }
      final initialDelay = firstRun.difference(now);

      await Workmanager().registerPeriodicTask(
        _matchReminderWorkName,
        _matchReminderTask,
        frequency: const Duration(hours: 1),
        initialDelay: initialDelay,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      );
      return;
    }

    await Workmanager().cancelByUniqueName(_matchReminderWorkName);
  }

  static Future<void> showTestNotification() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'test_notifications',
        'Test notifications',
        channelDescription: 'Test notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    await _notifications.show(
      999999,
      AppStrings.notificationsTestTitle,
      AppStrings.notificationsTestBody,
      details,
    );
  }
}
