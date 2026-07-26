import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/store_profile_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'sale', dbType: 1);

/// Captures light/dark PNGs of the new Commercial Space Productivity Index
/// widget (Issue #398) for QA. Not a golden comparison — it only records
/// the look.
void main() {
  final transactions = [_income(4500), _income(3200), _income(2100)];
  final storeProfile = StoreProfileEntity(squareFootage: 850);

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 320));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              padding: const EdgeInsets.all(12),
              child: SpaceProductivityReportWidget(
                  data: {'transactions': transactions, 'storeProfile': storeProfile},
                  title: 'Commercial Space Productivity Index'),
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      Directory('screenshots').createSync(recursive: true);
      File('screenshots/$file').writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  testWidgets('writes light and dark space-productivity screenshots', (tester) async {
    await capture(tester, Brightness.light, 'space_productivity_light.png');
    await capture(tester, Brightness.dark, 'space_productivity_dark.png');
    expect(File('screenshots/space_productivity_light.png').existsSync(), isTrue);
    expect(File('screenshots/space_productivity_dark.png').existsSync(), isTrue);
  });
}
