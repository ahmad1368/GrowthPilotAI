import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Inventory Valuation widget (Issue
/// #446) for QA. Not a golden comparison — it only records the look.
void main() {
  final flour = InventoryItemEntity(
      id: 1, name: 'Flour', quantityOnHand: 15, reorderThreshold: 5, unitCost: 3);
  final layers = [
    InventoryCostLayerEntity(
        itemId: 1, itemName: 'Flour', quantity: 10, unitCost: 2, receivedAt: DateTime(2026, 1, 1)),
    InventoryCostLayerEntity(
        itemId: 1, itemName: 'Flour', quantity: 10, unitCost: 4, receivedAt: DateTime(2026, 2, 1)),
  ];

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
              child: InventoryValuationReportWidget(
                  data: {'items': [flour], 'layers': layers}, title: 'Inventory Valuation'),
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

  testWidgets('writes light and dark inventory-valuation screenshots', (tester) async {
    await capture(tester, Brightness.light, 'inventory_valuation_light.png');
    await capture(tester, Brightness.dark, 'inventory_valuation_dark.png');
    expect(File('screenshots/inventory_valuation_light.png').existsSync(), isTrue);
    expect(File('screenshots/inventory_valuation_dark.png').existsSync(), isTrue);
  });
}
