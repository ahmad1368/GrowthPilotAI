import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_log_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

WasteLogEntity _entry(double value, WasteReason reason) => WasteLogEntity(
    itemDescription: 'item', estimatedValue: value, date: DateTime(2026, 1, 1))
  ..reason = reason;

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder and a zero total with no entries',
      (tester) async {
    await tester.pumpWidget(_wrap(const WasteLogReportWidget(
        data: {'wasteEntries': <WasteLogEntity>[]}, title: 'x')));

    expect(find.text('No waste logged yet.'), findsOneWidget);
    expect(find.textContaining('Total loss:'), findsOneWidget);
  });

  testWidgets('shows the highest-loss reason first', (tester) async {
    final entries = [
      _entry(5, WasteReason.damage),
      _entry(50, WasteReason.expiration),
    ];

    await tester.pumpWidget(
        _wrap(WasteLogReportWidget(data: {'wasteEntries': entries}, title: 'x')));

    final expirationCenter = tester.getCenter(find.textContaining('Expiration'));
    final damageCenter = tester.getCenter(find.textContaining('Damage'));
    expect(expirationCenter.dy, lessThan(damageCenter.dy));
  });

  testWidgets('shows the "+ Log Waste" quick-add button', (tester) async {
    await tester.pumpWidget(_wrap(const WasteLogReportWidget(
        data: {'wasteEntries': <WasteLogEntity>[]}, title: 'x')));

    expect(find.text('+ Log Waste'), findsOneWidget);
  });
}
