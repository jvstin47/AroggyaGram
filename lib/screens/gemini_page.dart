import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../services/gemini_service.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class GeminiConsultationPage extends StatefulWidget {
  const GeminiConsultationPage({super.key});

  @override
  State<GeminiConsultationPage> createState() => _GeminiConsultationPageState();
}

class _GeminiConsultationPageState extends State<GeminiConsultationPage> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isLoading = true;
    });
    _controller.clear();

    try {
      final response = await _geminiService.generateAdvice(text);
      setState(() {
        _messages.add({"role": "model", "text": response ?? "I couldn't process that."});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "model",
          "text": "Network connection error. If you are experiencing urgent symptoms, please do not wait. Tap the SOS button below immediately to alert your contact, or call emergency services."
        });
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
          // Chat ListView
          ListView(
            padding: const EdgeInsets.only(
              top: 110,
              left: 20,
              right: 20,
              bottom: 100, // space for input area
            ),
            children: [
              // Disclaimer Panel
              GlassPanel(
                backgroundColor: AppTheme.primaryFixed.withOpacity(0.3),
                borderColor: AppTheme.primaryFixed,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "AI consultation provides preliminary guidance only. Always consult a real doctor for medical advice.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // High Risk Alert
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.error,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emergency, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "High Risk: Please contact emergency services immediately.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ..._messages.map((m) {
                final isUser = m["role"] == "user";
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: isUser
                          ? GlassPanel(
                              backgroundColor: AppTheme.primaryContainer.withOpacity(0.9),
                              borderColor: Colors.transparent,
                              borderRadius: 24,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Text(
                                m["text"]!,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.onPrimaryContainer,
                                    ),
                              ),
                            )
                          : NeumorphicContainer(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              borderRadius: 24,
                              child: Text(
                                m["text"]!,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.onSurface,
                                    ),
                              ),
                            ),
                    ),
                  ),
                );
              }),

              if (_isLoading)
                Align(
                  alignment: Alignment.centerLeft,
                  child: NeumorphicContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    borderRadius: 24,
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
            ],
          ),

          // Custom Top App Bar
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
                    border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
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
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.psychology, color: AppTheme.onSecondaryContainer, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "AI Health Consult",
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

          // Bottom Input Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: NeumorphicContainer(
                          isInset: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          borderRadius: 24,
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: "Describe your symptoms...",
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.send, color: Colors.white),
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
