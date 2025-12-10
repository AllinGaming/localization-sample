import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'messages.i69n.dart';
import 'messages_ar.i69n.dart';
import 'messages_de.i69n.dart';
import 'messages_es.i69n.dart';
import 'messages_fr.i69n.dart';
import 'api_simulator.dart';
import 'dynamic_messages.dart';

export 'messages.i69n.dart';

class AppLocalizations {
  static const LocalizationsDelegate<Messages> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('ar'),
    Locale('it'),
  ];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<Messages> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.map((l) => l.languageCode).contains(locale.languageCode);
  }

  @override
  Future<Messages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'es':
        return const Messages_es();
      case 'fr':
        return const Messages_fr();
      case 'de':
        return const Messages_de();
      case 'ar':
        return const Messages_ar();
      case 'it':
        // Dynamic loading simulation
        try {
          final data = await ApiSimulator.fetchMessages('it');
          return DynamicMessages(data);
        } catch (e) {
          // Fallback to English or empty
          return const Messages();
        }
      case 'en':
      default:
        return const Messages();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Messages> old) => false;
}
