import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/category_mapping_controller.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/mapping_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the Category Mapping card (Issue #58) for
/// QA. Not a golden comparison — it only records the current look. Uses a
/// bare [CategoryMappingController] (never registered via Get.put, so
/// onInit/ObjectBox never runs) to satisfy MappingCard's constructor.
void main() {
  final group = MerchantMappingGroup(
    merchantName: 'Amazon',
    transactions: [
      TransactionEntity(amount: 42.5, date: DateTime(2026), description: 'Amazon'),
      TransactionEntity(amount: 18.0, date: DateTime(2026), description: 'Amazon'),
    ],
    mapping: const MappingResult(
      suggestedAccountId: '6200',
      confidence: 0.9,
      source: MappingSource.userRule,
    ),
  );
  final controller = CategoryMappingController();

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(420, 300));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MappingCard(group: group, controller: controller),
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

  testWidgets('writes light and dark mapping-card screenshots', (tester) async {
    await capture(tester, Brightness.light, 'mapping_card_light.png');
    await capture(tester, Brightness.dark, 'mapping_card_dark.png');
    expect(File('screenshots/mapping_card_light.png').existsSync(), isTrue);
    expect(File('screenshots/mapping_card_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
    Get.reset();
  });
}
