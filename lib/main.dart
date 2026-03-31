import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your screen files
import 'screens/dashboard_page.dart';
import 'screens/meds_tracker_page.dart';

// 🔔 Global notification plugin instance
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔔 Initialize local notifications
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings settings =
      InitializationSettings(android: androidSettings);
  await notificationsPlugin.initialize(settings);

  runApp(const GuardianHealthApp());
}

class GuardianHealthApp extends StatelessWidget {
  const GuardianHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
        primaryColor: const Color(0xFF43CEA2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF43CEA2),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MedsTrackerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔴 SOS BUTTON (CENTER)
      floatingActionButton: FloatingActionButton(
        onPressed: _triggerEmergency,
        backgroundColor: Colors.red,
        child: const Icon(Icons.sos, size: 28),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      // 🔺 TOP BAR
      appBar: AppBar(
        title: const Text("ArogyaGram"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
            ),
          ),
        ),
      ),

      // 📱 BODY
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      // 🔻 BOTTOM NAV (HOME + MEDS)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                onPressed: () => setState(() => _selectedIndex = 0),
              ),
              const SizedBox(width: 40), // space for SOS
              IconButton(
                icon: const Icon(Icons.medication),
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                onPressed: () => setState(() => _selectedIndex = 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🚨 Emergency SOS Button
  Future<void> _triggerEmergency() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition();
    final url =
        "sms:9539141210?body=EMERGENCY! My location: https://www.google.com/maps?q=${pos.latitude},${pos.longitude}";
    await launchUrl(Uri.parse(url));
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
