import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_directory_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Local Supplier Directory widget
/// (Issue #442) for QA. Not a golden comparison — it only records the
/// look.
void main() {
  final vendors = [
    VendorEntity(
        name: 'Acme Supplies',
        contactInfo: '555-1234',
        paymentTerms: 'Net 30',
        typicalLeadTimeDays: 5),
    VendorEntity(name: 'Metro Wholesale', contactInfo: 'orders@metro.example'),
    VendorEntity(name: 'Old Vendor Co', isActive: false),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 340));
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
              child: SupplierDirectoryReportWidget(
                  data: {'vendors': vendors}, title: 'Local Supplier Directory'),
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

  testWidgets('writes light and dark supplier-directory screenshots', (tester) async {
    await capture(tester, Brightness.light, 'supplier_directory_light.png');
    await capture(tester, Brightness.dark, 'supplier_directory_dark.png');
    expect(File('screenshots/supplier_directory_light.png').existsSync(), isTrue);
    expect(File('screenshots/supplier_directory_dark.png').existsSync(), isTrue);
  });
}
