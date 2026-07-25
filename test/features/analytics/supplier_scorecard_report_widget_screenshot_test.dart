import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {VendorEntity? vendor}) {
  final tx = TransactionEntity(amount: amount, date: date, description: 'x', dbType: 0);
  if (vendor != null) tx.vendor.target = vendor;
  return tx;
}

/// Captures light/dark PNGs of the new Supplier Price Scorecard widget
/// (Issue #369) for QA. Not a golden comparison — it only records the look.
void main() {
  final cheap = VendorEntity(name: 'BC Paper Supply');
  final rising = VendorEntity(name: 'North Shore Packaging');
  final transactions = [
    _tx(80, DateTime(2026, 1, 5), vendor: cheap),
    _tx(80, DateTime(2026, 2, 5), vendor: cheap),
    _tx(150, DateTime(2026, 1, 5), vendor: rising),
    _tx(220, DateTime(2026, 2, 5), vendor: rising),
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
            child: SupplierScorecardReportWidget(
                data: {'transactions': transactions}, title: 'Supplier Price Scorecard'),
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

  testWidgets('writes light and dark supplier-scorecard screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'supplier_scorecard_light.png');
    await capture(tester, Brightness.dark, 'supplier_scorecard_dark.png');
    expect(File('screenshots/supplier_scorecard_light.png').existsSync(), isTrue);
    expect(File('screenshots/supplier_scorecard_dark.png').existsSync(), isTrue);
  });
}
