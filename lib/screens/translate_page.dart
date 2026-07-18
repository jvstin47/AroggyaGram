import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = "";
  bool _isLoading = false;

  String _sourceLang = 'en';
  String _targetLang = 'ml'; // Malayalam default

  final Map<String, String> _languages = {
    'en': 'English',
    'ml': 'Malayalam',
    'hi': 'Hindi',
    'ta': 'Tamil',
    'bn': 'Bengali',
  };

  Future<void> _translate() async {
    if (_inputController.text.isEmpty) return;
    setState(() => _isLoading = true);

    try {
      final res = await http.post(
        Uri.parse('https://libretranslate.de/translate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': _inputController.text,
          'source': _sourceLang,
          'target': _targetLang,
          'format': 'text'
        }),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          _translatedText = data['translatedText'];
        });
      } else {
        setState(() {
          _translatedText = "Error: Translation failed.";
        });
      }
    } catch (e) {
      setState(() {
        _translatedText = "Network connection issue. If you need immediate assistance translating medical information, please try again or consult local community health workers directly.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Scrollable Content
          ListView(
            padding: const EdgeInsets.only(
              top: 100,
              left: 20,
              right: 20,
              bottom: 120, // space for bottom nav
            ),
            children: [
              // AI Insight Panel
              GlassPanel(
                backgroundColor: Colors.white.withOpacity(0.65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, color: AppTheme.secondary),
                        const SizedBox(width: 8),
                        Text(
                          "AI LANGUAGE ASSISTANT",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.secondary,
                                letterSpacing: 2.0,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Translate medical instructions, symptoms, or prescriptions accurately to your local language.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Source Input Area
              NeumorphicContainer(
                isInset: true,
                padding: const EdgeInsets.all(4),
                borderRadius: 24,
                child: Column(
                  children: [
                    // Lang Selector
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "FROM",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurfaceVariant),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _sourceLang,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.primary),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              onChanged: (val) => setState(() => _sourceLang = val!),
                              items: _languages.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black12),
                    // TextField
                    TextField(
                      controller: _inputController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Type medical text or symptoms here...",
                        hintStyle: TextStyle(color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.onSurface),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Translate Action Stack
              Stack(
                alignment: Alignment.center,
                children: [
                  const Divider(color: Colors.black12, thickness: 2),
                  NeumorphicContainer(
                    isInteractive: true,
                    onTap: _translate,
                    padding: const EdgeInsets.all(16),
                    borderRadius: 32,
                    color: AppTheme.primary,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                          )
                        : const Icon(Icons.swap_vert, color: Colors.white, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Output Area
              GlassPanel(
                backgroundColor: AppTheme.primaryFixed.withOpacity(0.3),
                borderColor: AppTheme.primaryFixed,
                borderRadius: 24,
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Lang Selector
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TO",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurfaceVariant),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _targetLang,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.primary),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              onChanged: (val) => setState(() => _targetLang = val!),
                              items: _languages.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black12),
                    // Output Text
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _translatedText.isEmpty ? "Translation will appear here." : _translatedText,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.onSurface,
                              height: 1.5,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),

          // Custom Top App Bar (Glass)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.4))),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.read<NavigationProvider>().pop(),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: AppTheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              "BACK",
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Medical Translator",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
