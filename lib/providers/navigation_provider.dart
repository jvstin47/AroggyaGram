import 'package:flutter/material.dart';

enum AppScreen {
  dashboard,
  medsTracker,
  pharmacy,
  translate,
  gemini,
  emergencyFallback,
  medicationAlarm,
}

class NavigationProvider with ChangeNotifier {
  final List<AppScreen> _history = [AppScreen.dashboard];

  AppScreen get currentScreen => _history.last;

  bool get canPop => _history.length > 1;

  void push(AppScreen screen) {
    _history.add(screen);
    notifyListeners();
  }

  void pop() {
    if (canPop) {
      _history.removeLast();
      notifyListeners();
    }
  }

  void setTab(AppScreen screen) {
    _history.clear();
    _history.add(screen);
    notifyListeners();
  }
}
