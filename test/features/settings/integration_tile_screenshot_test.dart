import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/integration_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the Integrations Dashboard tile (Issue #61)
/// for QA. Not a golden comparison — it only records the current look.
void main() {
  final connected = IntegrationConnectionEntity(
    providerId: 'quickbooks',
    providerLabel: 'QuickBooks',
    dbStatus: DashboardConnectionStatus.connected.index,
    accountLabel: 'mock-realm-123',
    lastSyncedAt: DateTime.now(),
  );

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(420, 240));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: MappingShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IntegrationTile(
                entity: connected,
                isBusy: false,
                onConnect: () {},
                onDisconnect: () {},
              ),
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

  testWidgets('writes light and dark integration-tile screenshots', (tester) async {
    await capture(tester, Brightness.light, 'integration_tile_light.png');
    await capture(tester, Brightness.dark, 'integration_tile_dark.png');
    expect(File('screenshots/integration_tile_light.png').existsSync(), isTrue);
    expect(File('screenshots/integration_tile_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
