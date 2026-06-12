import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/scanner/screens/presentation/widgets/receipt_scanner_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('ReceiptScannerScreen renders all flat components properly',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: ReceiptScannerScreen(),
        ),
      ),
    );

    expect(
        find.text('برای شروع اسکن، دوربین را روی رسید بگیرید'), findsOneWidget);
    expect(find.text('در انتظار تصویر برای استخراج متنی...'), findsOneWidget);
    expect(find.byType(ShadCard), findsNWidgets(2));
  });
}
