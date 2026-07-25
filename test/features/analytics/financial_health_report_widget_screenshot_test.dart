import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_report_widget.dart';

LinkedAccountEntity _account(String type, double balance, {String id = 'a1'}) =>
    LinkedAccountEntity(
      accountId: id,
      institutionName: 'Bank',
      officialName: 'Account',
      mask: '0000',
      accountType: type,
      currentBalance: balance,
    );

/// Captures light/dark PNGs of the new Financial Health & Liquidity widget
/// (Issue #385) for QA. Not a golden comparison — it only records the look.
void main() {
  final accounts = [
    _account('depository', 8500, id: 'a1'),
    _account('credit', 3000, id: 'a2'),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 320));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: FinancialHealthReportWidget(
                data: {'accounts': accounts}, title: 'Financial Health & Liquidity'),
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

  testWidgets('writes light and dark financial-health screenshots', (tester) async {
    await capture(tester, Brightness.light, 'financial_health_light.png');
    await capture(tester, Brightness.dark, 'financial_health_dark.png');
    expect(File('screenshots/financial_health_light.png').existsSync(), isTrue);
    expect(File('screenshots/financial_health_dark.png').existsSync(), isTrue);
  });
}
