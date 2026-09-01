import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/data_source_switcher_tile.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// GetMaterialApp (not plain MaterialApp) because toggleDataSource() calls
// Get.snackbar, which needs Get's own navigator/overlay to be registered.
Widget _wrap(Widget child) => GetMaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  tearDown(Get.reset);

  testWidgets('shows the current data source state (Issue #264/#265)', (tester) async {
    final env = Get.put(EnvironmentService());
    env.isRemoteEnabled.value = false;
    await tester.pumpWidget(_wrap(const DataSourceSwitcherTile()));

    expect(find.text('Remote Access'), findsOneWidget);
    final switchWidget = tester.widget<ShadSwitch>(find.byType(ShadSwitch));
    expect(switchWidget.value, isFalse);
  });

  testWidgets('tapping the switch toggles EnvironmentService.isRemoteEnabled', (tester) async {
    final env = Get.put(EnvironmentService());
    env.isRemoteEnabled.value = false;
    await tester.pumpWidget(_wrap(const DataSourceSwitcherTile()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ShadSwitch));
    await tester.pump();

    expect(env.isRemoteEnabled.value, isTrue);
  });
}
