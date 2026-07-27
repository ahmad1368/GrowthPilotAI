import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Real-Time Stock Tracking widget
/// (Issue #439) for QA. Not a golden comparison — it only records the look.
void main() {
  final sale = StockMovementEntity(
      itemName: 'Flour',
      quantity: 4,
      resultingQuantityOnHand: 6,
      occurredAt: DateTime(2026, 1, 5))
    ..type = StockMovementType.sale;

  final returnStock = StockMovementEntity(
      itemName: 'Sugar',
      quantity: 5,
      resultingQuantityOnHand: 25,
      occurredAt: DateTime(2026, 1, 3))
    ..type = StockMovementType.returnStock;

  final movements = [sale, returnStock];

  final reservation = StockReservationEntity(
      itemId: 1, itemName: 'Flour', quantityReserved: 2, createdAt: DateTime(2026, 1, 6));

  Future<void> capture(WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark ? const Color(0xFF09090B) : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 480));
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
              child: StockMovementReportWidget(
                  data: {
                    'movements': movements,
                    'items': const <InventoryItemEntity>[],
                    'reservations': [reservation],
                  },
                  title: 'Real-Time Stock Tracking'),
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      Directory('screenshots').createSync(recursive: true);
      File('screenshots/$file').writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  testWidgets('writes light and dark stock-movement screenshots', (tester) async {
    await capture(tester, Brightness.light, 'stock_movement_light.png');
    await capture(tester, Brightness.dark, 'stock_movement_dark.png');
    expect(File('screenshots/stock_movement_light.png').existsSync(), isTrue);
    expect(File('screenshots/stock_movement_dark.png').existsSync(), isTrue);
  });
}
