import 'package:flutter/material.dart';
import 'package:app_localization/setup.dart';
import 'package:app_accessibility/accessible_touch_target.dart';
import 'package:app_accessibility/semantic_header.dart';
import 'package:app_accessibility/accessibility_announcer.dart';
import 'package:app_accessibility/reduced_motion.dart';
import 'package:app_accessibility/scalable_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  final Map<String, String> _languageNames = {
    'en': 'English',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'ar': 'العربية',
    'it': 'Italiano',
  };

  @override
  void initState() {
    super.initState();
    // Auto-detect system locale
    // We use a post-frame callback or just set it here if we don't need context.
    // PlatformDispatcher is in dart:ui.
    final systemLocale =  WidgetsBinding.instance.platformDispatcher.locale;
    final isSupported = AppLocalizations.supportedLocales.any((l) => l.languageCode == systemLocale.languageCode);
    if (isSupported) {
      _locale = Locale(systemLocale.languageCode);
    }
  }

  void _changeLocale(Locale? newLocale) {
    if (newLocale != null) {
      setState(() {
        _locale = newLocale;
      });
      AccessibilityAnnouncer.announce('Switched language to ${_languageNames[newLocale.languageCode]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          final messages = Localizations.of<Messages>(context, Messages)!;
          
          return Scaffold(
            appBar: AppBar(
              title: SemanticHeader(child: Text(messages.main.title)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(messages.main.welcome('User')),
                  const SizedBox(height: 20),
                  
                  // Reduced Motion Example
                  const ReducedMotion(
                    motionChild: CircularProgressIndicator(value: 0.7),
                    staticChild: Icon(Icons.check_circle, size: 48, color: Colors.green, semanticLabel: 'Success'),
                  ),
                  const SizedBox(height: 20),

                  Text(messages.main.counter.zero),
                  Text(messages.main.counter.one),
                  Text(messages.main.counter.many(5)),
                  const SizedBox(height: 20),
                  
                  // Scalable Layout Example
                  ScalableLayout(
                    children: [
                      AccessibleTouchTarget(
                        child: DropdownButton<Locale>(
                          value: _locale,
                          items: AppLocalizations.supportedLocales.map((locale) {
                            return DropdownMenuItem(
                              value: locale,
                              child: Text(_languageNames[locale.languageCode] ?? locale.languageCode),
                            );
                          }).toList(),
                          onChanged: _changeLocale,
                          hint: Text(messages.generic.ok), // Fallback/Hint
                        ),
                      ),
                      const SizedBox(width: 10, height: 10),
                      Text('Current Locale: ${_locale.languageCode}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
