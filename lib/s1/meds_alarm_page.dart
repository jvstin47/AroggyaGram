import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MedsAlarmPage extends StatefulWidget {
  const MedsAlarmPage({super.key});
  @override
  State<MedsAlarmPage> createState() => _MedsAlarmPageState();
}

class _MedsAlarmPageState extends State<MedsAlarmPage> {
  int _seconds = 0;
  Timer? _timer;

  void _start(int s) {
    _timer?.cancel();
    setState(() => _seconds = s);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        t.cancel();
        _ring();
      }
    });
  }

  void _ring() {
    HapticFeedback.vibrate();
    showDialog(
      context: context, 
      builder: (c) => AlertDialog(
        title: const Text("MEDS TIME"), 
        content: const Text("It is time to take your medicine."),
        actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("OK"))]
      )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.alarm, size: 100, color: Color(0xFF3F77F3)),
      Text("${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}", 
        style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w200)),
      ElevatedButton(onPressed: () => _start(10), child: const Text("Set 10s Test Alarm"))
    ]));
  }
}
