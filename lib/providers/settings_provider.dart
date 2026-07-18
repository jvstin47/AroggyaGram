import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _emergencyContact = "9539141210";

  String get emergencyContact => _emergencyContact;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _emergencyContact = prefs.getString('emergency_contact') ?? "9539141210";
    notifyListeners();
  }

  Future<void> updateEmergencyContact(String newContact) async {
    _emergencyContact = newContact;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emergency_contact', newContact);
    notifyListeners();
  }
}
