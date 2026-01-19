import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'data/local/prefs_store.dart';
import 'services/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Enable immersive sticky mode - hides navigation bar, respects top safe area
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );

  await NotificationService.initialize();
  final prefs = await PrefsStore.create();
  if (prefs.localRemindersEnabled &&
      !(await NotificationService.areNotificationsEnabled())) {
    await prefs.setLocalRemindersEnabled(false);
    await NotificationService.setMatchRemindersEnabled(false);
  } else {
    await NotificationService.setMatchRemindersEnabled(
      prefs.localRemindersEnabled,
    );
  }

  runApp(const App());
}