import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the Inventory Management widget (Issue
/// #435, hierarchical categories in #436, SKU field in #437) for QA. Not a
/// golden comparison — it only records the look.
void main() {
  final bakery = InventoryCategoryEntity(name: 'Bakery');
  final flour = InventoryItemEntity(
      name: 'Flour', quantityOnHand: 2, reorderThreshold: 10, unitCost: 3.5, sku: 'BAK-0001')
    ..category.target = bakery;
  final items = [
    flour,
    InventoryItemEntity(name: 'Sugar', quantityOnHand: 40, reorderThreshold: 10, unitCost: 2),
    InventoryItemEntity(name: 'Butter', quantityOnHand: 15, reorderThreshold: 5, unitCost: 6),
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
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              padding: const EdgeInsets.all(12),
              child: InventoryReportWidget(
                  data: {'items': items, 'categories': [bakery]},
                  title: 'Inventory Management'),
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

  testWidgets('writes light and dark inventory screenshots', (tester) async {
    await capture(tester, Brightness.light, 'inventory_light.png');
    await capture(tester, Brightness.dark, 'inventory_dark.png');
    expect(File('screenshots/inventory_light.png').existsSync(), isTrue);
    expect(File('screenshots/inventory_dark.png').existsSync(), isTrue);
  });
}
