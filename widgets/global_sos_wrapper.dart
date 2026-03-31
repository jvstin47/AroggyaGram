import 'package:flutter/material.dart';
import '../screens/emergency_page.dart';

class GlobalSOSWrapper extends StatelessWidget {
  final Widget child;

  const GlobalSOSWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencyPage(),
                ),
              );
            },
            icon: const Icon(Icons.warning, color: Colors.white),
            label: const Text("SOS",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
