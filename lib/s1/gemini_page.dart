import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/global_sos_wrapper.dart';

class GeminiConsultationPage extends StatefulWidget {
  const GeminiConsultationPage({super.key});

  @override
  State<GeminiConsultationPage> createState() =>
      _GeminiConsultationPageState();
}

class _GeminiConsultationPageState
    extends State<GeminiConsultationPage> {

  final String apiKey = "AIzaSyAYT3p3j0XEDE5eB0JWTl6clOu6ges0qZM";

  final List<Map<String, String>> _messages = [
    {
      "role": "gemini",
      "text":
          "Hello, I am your AI health assistant. How are you feeling today?"
    }
  ];

  final TextEditingController _chatController =
      TextEditingController();

  // 🧠 Healthcare prompt builder
  String buildHealthcarePrompt(String userMessage) {
    return """
You are a rural healthcare assistant.

Analyze the user's symptoms and respond STRICTLY in this format:

1. Possible Condition:
2. Risk Level: (LOW / MEDIUM / HIGH)
3. Emergency Warning: (only if serious, else say "None")
4. Advice:

If user writes in Malayalam, reply in Malayalam. Otherwise English.

Keep it short, simple, and helpful.

User symptoms:
$userMessage
""";
  }

  Future<void> _sendMessage() async {
    if (_chatController.text.trim().isEmpty) return;

    String userMessage = _chatController.text.trim();

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
      _messages.add({"role": "gemini", "text": "Typing..."});
    });

    _chatController.clear();

    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": _messages
              .where((msg) => msg["text"] != "Typing...")
              .map((msg) => {
                    "role":
                        msg["role"] == "user" ? "user" : "model",
                    "parts": [
                      {
                        "text": msg["role"] == "user"
                            ? buildHealthcarePrompt(msg["text"]!)
                            : msg["text"]
                      }
                    ]
                  })
              .toList(),
        }),
      );

      // 🔍 Debug logs
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["candidates"] != null &&
            data["candidates"].isNotEmpty) {

          String geminiReply =
              data["candidates"][0]["content"]["parts"][0]["text"];

          setState(() {
            _messages.removeLast();
            _messages.add({
              "role": "gemini",
              "text": geminiReply
            });
          });

        } else {
          throw Exception("Empty response");
        }

      } else {
        setState(() {
          _messages.removeLast();
          _messages.add({
            "role": "gemini",
            "text":
                "API Error: ${response.statusCode}\n${response.body}"
          });
        });
      }

    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add({
          "role": "gemini",
          "text": "Error: $e"
        });
      });
    }
  }

  // 🎨 Chat bubble UI with emergency highlight
  Widget _buildMessage(Map<String, String> message) {
    bool isGemini = message["role"] == "gemini";
    bool isEmergency = message["text"]!.contains("HIGH") ||
        message["text"]!.contains("🚨");

    return Align(
      alignment:
          isGemini ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isGemini
              ? (isEmergency
                  ? Colors.red[100]
                  : Colors.white)
              : const Color(0xFF3F77F3),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5)
          ],
        ),
        child: Text(
          message["text"]!,
          style: TextStyle(
            color: isGemini
                ? Colors.black87
                : Colors.white,
          ),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return GlobalSOSWrapper(
    child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      decoration: InputDecoration(
                        hintText: "Describe your symptoms...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
