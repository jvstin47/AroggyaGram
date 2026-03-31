import 'package:flutter/material.dart';

class MedsTrackerPage extends StatefulWidget {
  const MedsTrackerPage({super.key});

  @override
  State<MedsTrackerPage> createState() => _MedsTrackerPageState();
}

class _MedsTrackerPageState extends State<MedsTrackerPage> {
  final List<Map<String, dynamic>> meds = [];

  void addMedicine(String name, String time, String dosage) {
    setState(() {
      meds.add({
        "name": name,
        "time": time,
        "dosage": dosage,
        "taken": false
      });
    });
  }

  void showAddDialog() {
    TextEditingController name = TextEditingController();
    TextEditingController time = TextEditingController();
    TextEditingController dosage = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Medicine"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: "Medicine Name")),
            TextField(controller: time, decoration: const InputDecoration(labelText: "Time (e.g. 8 AM)")),
            TextField(controller: dosage, decoration: const InputDecoration(labelText: "Dosage")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              addMedicine(name.text, time.text, dosage.text);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medication Tracker")),
      body: ListView.builder(
        itemCount: meds.length,
        itemBuilder: (context, index) {
          final med = meds[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("${med["name"]} (${med["dosage"]})"),
              subtitle: Text("Time: ${med["time"]}"),
              trailing: Checkbox(
                value: med["taken"],
                onChanged: (val) {
                  setState(() {
                    med["taken"] = val;
                  });
                },
              ),
              onLongPress: () {
                setState(() {
                  meds.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
