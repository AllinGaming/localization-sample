import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example_app/main.dart';
import 'package:app_accessibility/accessible_touch_target.dart';
import 'package:app_accessibility/scalable_layout.dart';

void main() {
  testWidgets('Localization smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the title is in English initially.
    expect(find.text('i69n Example'), findsOneWidget);
    expect(find.text('Hello User!'), findsOneWidget);
    expect(find.text('You have clicked zero times'), findsOneWidget);

    // Switch to Spanish
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Español').last);
    await tester.pumpAndSettle();

    // Verify that the title is now in Spanish.
    expect(find.text('Ejemplo i69n'), findsOneWidget);
    expect(find.text('Hola User!'), findsOneWidget);
    expect(find.text('Has hecho clic cero veces'), findsOneWidget);

    final Semantics headerSemantics = tester.widget(
      find.ancestor(
        of: find.text('Ejemplo i69n'),
        matching: find.byType(Semantics),
      ).first,
    );
    expect(headerSemantics.properties.header, isTrue);

    // Verify Accessible Touch Target Size
    final Size buttonSize = tester.getSize(find.byType(AccessibleTouchTarget));
    expect(buttonSize.width, greaterThanOrEqualTo(48.0));
    expect(buttonSize.height, greaterThanOrEqualTo(48.0));

    // Verify ReducedMotion (Default is no reduction)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verify ScalableLayout (Default scale is 1.0, so Row)
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(ScalableLayout), findsOneWidget);

    // Switch to French
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français').last);
    await tester.pumpAndSettle();
    
    expect(find.text('Exemple i69n'), findsOneWidget);
    expect(find.text('Bonjour User!'), findsOneWidget);

    // Switch to German
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Deutsch').last);
    await tester.pumpAndSettle();

    expect(find.text('i69n Beispiel'), findsOneWidget);
    expect(find.text('Hallo User!'), findsOneWidget);

    // Switch to Arabic
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('العربية').last);
    await tester.pumpAndSettle();

    expect(find.text('مثال i69n'), findsOneWidget);
    expect(find.text('أهلا User!'), findsOneWidget);
    
    // Verify RTL directionality for Arabic
    final Directionality directionality = tester.widget(find.byType(Directionality).last);
    expect(directionality.textDirection, TextDirection.rtl);

    // Switch to Italian (Dynamic)
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Italiano').last);
    await tester.pumpAndSettle();
    
    // Wait for the simulated network delay (500ms) + frame
    await tester.pump(const Duration(milliseconds: 600)); 
    await tester.pumpAndSettle();
    
    expect(find.text('Esempio i69n'), findsOneWidget);
    expect(find.text('Ciao User!'), findsOneWidget);
    expect(find.text('Hai cliccato zero volte'), findsOneWidget);
  });
}
