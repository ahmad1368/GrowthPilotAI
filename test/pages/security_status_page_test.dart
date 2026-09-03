import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/pages/security_status_page.dart';

void main() {
  group('SecurityStatusPage (Issue #16)', () {
    testWidgets('does not claim the database is AES-256 encrypted', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SecurityStatusPage()));

      expect(find.textContaining('AES-256'), findsNothing);
      expect(find.textContaining('encrypted'), findsNothing);
    });

    testWidgets('does not claim a hardware-backed key or biometric protection', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SecurityStatusPage()));

      expect(find.textContaining('hardware-backed', findRichText: true), findsNothing);
      expect(find.textContaining('Biometric', findRichText: true), findsNothing);
      expect(find.textContaining('biometric', findRichText: true), findsNothing);
    });

    testWidgets('accurately states encryption at rest is not yet enabled', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SecurityStatusPage()));

      expect(find.textContaining('Not yet enabled'), findsOneWidget);
    });
  });
}
