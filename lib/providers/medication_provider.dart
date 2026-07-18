import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MedicationProvider with ChangeNotifier {
  List<Map<String, dynamic>> _meds = [];

  List<Map<String, dynamic>> get meds => _meds;

  MedicationProvider() {
    _loadMeds();
  }

  Future<void> _loadMeds() async {
    final prefs = await SharedPreferences.getInstance();
    final String? medsString = prefs.getString('saved_meds');
    if (medsString != null) {
      final List<dynamic> decoded = jsonDecode(medsString);
      _meds = decoded.map((item) => Map<String, dynamic>.from(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveMeds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_meds', jsonEncode(_meds));
  }

  void addMedicine(String name, String time, String dosage) {
    _meds.add({
      "name": name,
      "time": time,
      "dosage": dosage,
      "taken": false,
    });
    _saveMeds();
    notifyListeners();
  }

  void toggleTaken(int index, bool? value) {
    if (index >= 0 && index < _meds.length) {
      _meds[index]["taken"] = value ?? false;
      _saveMeds();
      notifyListeners();
    }
  }

  void removeMedicine(int index) {
    if (index >= 0 && index < _meds.length) {
      _meds.removeAt(index);
      _saveMeds();
      notifyListeners();
    }
  }
}
