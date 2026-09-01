import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {CategoryEntity? category}) {
  final tx =
      TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);
  if (category != null) tx.category.target = category;
  return tx;
}

/// Captures light/dark PNGs of the new Service Price Elasticity widget
/// (Issue #380) for QA. Not a golden comparison — it only records the look.
void main() {
  final consulting = CategoryEntity(name: 'Consulting');
  final repairs = CategoryEntity(name: 'Repairs');
  final transactions = [
    _tx(100, DateTime(2026, 1, 1), category: consulting),
    _tx(100, DateTime(2026, 1, 5), category: consulting),
    _tx(200, DateTime(2026, 2, 1), category: consulting),
    _tx(80, DateTime(2026, 1, 1), category: repairs),
    _tx(120, DateTime(2026, 2, 1), category: repairs),
    _tx(120, DateTime(2026, 2, 5), category: repairs),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 420));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: CategoryElasticityReportWidget(
                data: {'transactions': transactions}, title: 'Service Price Elasticity'),
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

  testWidgets('writes light and dark category-elasticity screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'category_elasticity_light.png');
    await capture(tester, Brightness.dark, 'category_elasticity_dark.png');
    expect(File('screenshots/category_elasticity_light.png').existsSync(), isTrue);
    expect(File('screenshots/category_elasticity_dark.png').existsSync(), isTrue);
  });
}
