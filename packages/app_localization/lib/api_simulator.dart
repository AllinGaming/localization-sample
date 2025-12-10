class ApiSimulator {
  static Future<Map<String, dynamic>> fetchMessages(String locale) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (locale == 'it') {
      return {
        'generic': {
          'ok': 'OK',
          'done': 'Fatto',
          'cancel': 'Annulla',
        },
        'main': {
          'title': 'Esempio i69n',
          'welcome': 'Ciao \$name!',
          'counter': {
            'zero': 'Hai cliccato zero volte',
            'one': 'Hai cliccato una volta',
            'many': 'Hai cliccato \$count volte',
          },
        },
      };
    }
    throw Exception('Locale not found');
  }
}
