import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/account_list_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the Connected Accounts row (Issue #68) for
/// QA. Not a golden comparison — it only records the current look.
void main() {
  final account = LinkedAccountEntity(
    accountId: 'td-chequing-01',
    institutionName: 'TD Canada Trust',
    officialName: 'TD Business Chequing',
    mask: '4521',
    accountType: 'depository',
    currentBalance: 12480.55,
  );

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(420, 100));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              child: AccountListItem(
                account: account,
                isBusy: false,
                onToggle: (_) {},
                onFixConnection: () {},
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

  testWidgets('writes light and dark account-list-item screenshots', (tester) async {
    await capture(tester, Brightness.light, 'account_list_item_light.png');
    await capture(tester, Brightness.dark, 'account_list_item_dark.png');
    expect(File('screenshots/account_list_item_light.png').existsSync(), isTrue);
    expect(File('screenshots/account_list_item_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
