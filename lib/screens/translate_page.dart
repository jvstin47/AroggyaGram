import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _input = TextEditingController();
  String _output = "";
  String from = "en";
  String to = "ml";

  Future<void> translate() async {
    if (_input.text.isEmpty) return;

    final res = await http.post(
      Uri.parse("https://libretranslate.de/translate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "q": _input.text,
        "source": from,
        "target": to,
        "format": "text"
      }),
    );

    final data = jsonDecode(res.body);

    setState(() {
      _output = data["translatedText"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _input,
            decoration: const InputDecoration(
              hintText: "Enter text...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: translate, child: const Text("Translate")),
          const SizedBox(height: 20),
          Text(_output, style: const TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}
