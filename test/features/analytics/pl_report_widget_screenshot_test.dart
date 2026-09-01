import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_report_widget.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime.now(), description: 'Client payment', dbType: 1);
TransactionEntity _expense(double amount, String desc, CategoryEntity category) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime.now(), description: desc, dbType: 0);
  tx.category.target = category;
  return tx;
}

/// Captures light/dark PNGs of the new P&L Report widget (Issue #355) for
/// QA. Not a golden comparison — it only records the current look.
void main() {
  final rent = CategoryEntity(name: 'Rent');
  final supplies = CategoryEntity(name: 'Supplies');
  final transactions = [
    _income(5000),
    _expense(1800, 'Storefront lease', rent),
    _expense(600, 'Packaging order', supplies),
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
            child: PLReportWidget(
                data: {'transactions': transactions}, title: 'P&L Report'),
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

  testWidgets('writes light and dark P&L report screenshots', (tester) async {
    await capture(tester, Brightness.light, 'pl_report_light.png');
    await capture(tester, Brightness.dark, 'pl_report_dark.png');
    expect(File('screenshots/pl_report_light.png').existsSync(), isTrue);
    expect(File('screenshots/pl_report_dark.png').existsSync(), isTrue);
  });
}
