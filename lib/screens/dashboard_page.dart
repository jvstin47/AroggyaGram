import 'package:flutter/material.dart';
import 'pharmacy_page.dart';
import 'gemini_page.dart';
import 'meds_tracker_page.dart';
import 'translate_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 👋 HEADER
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/logo.jpeg"),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Hello 👋", style: TextStyle(fontSize: 16)),
                  Text("ArogyaGram User",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),

          const SizedBox(height: 20),

          // 🚨 EMERGENCY CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Emergency? Tap the SOS button below immediately.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ⚡ QUICK ACTIONS
          const Text("Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildCard(context, Icons.local_pharmacy, "Pharmacy", Colors.green, const PharmacyPage()),
              _buildCard(context, Icons.auto_awesome, "AI Consult", Colors.blue, GeminiConsultationPage()),
              _buildCard(context, Icons.alarm, "Medication", Colors.orange, MedsTrackerPage()),
              _buildCard(context, Icons.translate, "Translate", Colors.purple, TranslatePage()),
            ],
          ),

          const SizedBox(height: 25),

          // 📊 HEALTH INSIGHT CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3F77F3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("AI Health Insight",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  "You have no critical symptoms today. Stay hydrated and maintain medication schedule.",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 💊 MEDS CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05), blurRadius: 5)
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.medication, color: Colors.green, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Next Medicine: Paracetamol at 8:00 PM",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎴 CARD BUILDER
  Widget _buildCard(BuildContext context, IconData icon, String title, Color color, Widget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    ),
  );
}
}
