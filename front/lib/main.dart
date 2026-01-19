import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
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

  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
