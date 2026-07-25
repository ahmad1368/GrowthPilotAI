import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {VendorEntity? vendor}) {
  final tx = TransactionEntity(amount: amount, date: date, description: 'x', dbType: 0);
  if (vendor != null) tx.vendor.target = vendor;
  return tx;
}

void main() {
  testWidgets('shows a placeholder when there are no vendor-tagged expenses',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SupplierScorecardReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No vendor-tagged expenses yet.'), findsOneWidget);
  });

  testWidgets('lists the cheapest vendor first, marked with a star',
      (tester) async {
    final cheap = VendorEntity(name: 'Cheap Co');
    final pricey = VendorEntity(name: 'Pricey Inc');
    final transactions = [
      _tx(100, DateTime(2026, 1, 1), vendor: cheap),
      _tx(500, DateTime(2026, 1, 1), vendor: pricey),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SupplierScorecardReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    final cheapCenter = tester.getCenter(find.text('Cheap Co'));
    final priceyCenter = tester.getCenter(find.text('Pricey Inc'));
    expect(cheapCenter.dy, lessThan(priceyCenter.dy));
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
  });
}
