import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_accessibility/reduced_motion.dart';
import 'package:app_accessibility/scalable_layout.dart';

void main() {
  testWidgets('ReducedMotion shows static child and has Alt Text when animations are disabled', (WidgetTester tester) async {
    // Build with animations disabled
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: ReducedMotion(
            motionChild: CircularProgressIndicator(),
            staticChild: Icon(Icons.check_circle, semanticLabel: 'Success'),
          ),
        ),
      ),
    );

    // Verify Static Child is shown
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify Alt Text (Semantic Label)
    expect(find.bySemanticsLabel('Success'), findsOneWidget);
  });

  testWidgets('ScalableLayout switches to Column at 200% text scale', (WidgetTester tester) async {
    // Build with 2.0 text scale factor
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: ScalableLayout(
            children: [
              Text('Item 1'),
              Text('Item 2'),
            ],
          ),
        ),
      ),
    );

    // Verify Column is used (ScalableLayout returns Column when scale > threshold)
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsNothing);
  });
}
