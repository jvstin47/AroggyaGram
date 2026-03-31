import 'package:flutter/material.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meds = [
      {"name": "Paracetamol", "price": "₹20"},
      {"name": "Amoxicillin", "price": "₹85"},
      {"name": "ORS Pack", "price": "₹15"},
      {"name": "Vitamin C", "price": "₹50"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: meds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final med = meds[index];

          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.medication, color: Colors.white, size: 40),
                  Text(med["name"]!,
                      style: const TextStyle(color: Colors.white)),
                  Text(med["price"]!,
                      style: const TextStyle(color: Colors.white70)),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Buy"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
