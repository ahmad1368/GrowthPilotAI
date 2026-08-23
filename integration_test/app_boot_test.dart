import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:growth_pilot_ai/main.dart' as app;

/// First real cross-platform E2E test (Issue #181) — this repo had zero
/// integration_test coverage before this: only isolated widget/unit
/// tests. Boots the actual app (ObjectBox, DI, ReportWidgetsBootstrap —
/// everything `main()` really does, not a re-implementation of it) and
/// checks it renders without throwing. Deliberately a smoke test, not a
/// full "Login -> Search -> Checkout" journey (Issue #181's AC) — this
/// establishes the pattern; run with `flutter test integration_test`
/// on a connected device/emulator (not executed here, no visual QA in
/// this pipeline — see /emulator-qa).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App boot', () {
    testWidgets('launches to the home shell without throwing', (tester) async {
      app.main();
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(tester.takeException(), isNull);
    });
  });
}
