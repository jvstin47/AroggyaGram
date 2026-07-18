import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/medication_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/navigation_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/main_scaffold.dart';

// 🔔 Global notification plugin instance
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // 🔔 Initialize local notifications
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings settings =
      InitializationSettings(android: androidSettings);
  await notificationsPlugin.initialize(settings);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const GuardianHealthApp(),
    ),
  );
}

class GuardianHealthApp extends StatelessWidget {
  const GuardianHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AarogyaGram',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const MainScaffold(),
    );
  }
}

// 🔔 Show medication reminder notification
Future<void> showMedicationNotification() async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'med_channel',
    'Medication Alerts',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails details =
      NotificationDetails(android: androidDetails);

  await notificationsPlugin.show(
    0,
    'Medication Reminder',
    'Time to take your medicine 💊',
    details,
  );
}
