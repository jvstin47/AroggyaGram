import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String _apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? "";

  Future<String?> generateAdvice(String userMessage) async {
    return sendMessage([{"role": "user", "text": userMessage}]);
  }

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

  Future<String> sendMessage(List<Map<String, String>> messages) async {
    if (_apiKey.isEmpty) {
      throw Exception("API key is not configured.");
    }

    final formattedMessages = messages
        .where((msg) => msg["text"] != "Typing...")
        .map((msg) => {
              "role": msg["role"] == "user" ? "user" : "model",
              "parts": [
                {
                  "text": msg["role"] == "user"
                      ? buildHealthcarePrompt(msg["text"]!)
                      : msg["text"]
                }
              ]
            })
        .toList();

    try {
      final response = await http.post(
        Uri.parse("$_apiUrl?key=$_apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": formattedMessages,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["candidates"] != null && data["candidates"].isNotEmpty) {
          return data["candidates"][0]["content"]["parts"][0]["text"];
        } else {
          throw Exception("Empty response from AI.");
        }
      } else {
        throw Exception("API Error: \${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
