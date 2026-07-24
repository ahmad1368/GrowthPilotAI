import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_template_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_gallery.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_registry.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class _NullLayoutStore implements WidgetLayoutStore {
  @override
  Future<List<WidgetLayout>?> load() async => null;
  @override
  Future<void> save(List<WidgetLayout> layout) async {}
}

class _NullTemplateStore implements DashboardTemplateStore {
  @override
  Future<void> backupLayout(List<WidgetLayout> layout) async {}
  @override
  Future<List<WidgetLayout>?> loadBackup() async => null;
}

void main() {
  tearDown(Get.reset);

  testWidgets('shows one card per registered archetype, no Restore chip by default',
      (tester) async {
    final layoutController = Get.put(WidgetLayoutController(_NullLayoutStore()));
    Get.put(DashboardTemplateController(layoutController, _NullTemplateStore()));

    await tester.pumpWidget(MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: const Scaffold(body: DashboardTemplateGallery()),
      ),
    ));

    for (final template in DashboardTemplateRegistry.all) {
      expect(find.text(template.name), findsOneWidget);
    }
    expect(find.text('Restore custom'), findsNothing);
  });

  testWidgets('tapping a card applies the template and shows Restore custom',
      (tester) async {
    final layoutController = Get.put(WidgetLayoutController(_NullLayoutStore()));
    Get.put(DashboardTemplateController(layoutController, _NullTemplateStore()));

    await tester.pumpWidget(MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: const Scaffold(body: DashboardTemplateGallery()),
      ),
    ));

    await tester.tap(find.text(DashboardTemplateRegistry.all.first.name));
    await tester.pump();

    expect(find.text('Restore custom'), findsOneWidget);
  });
}
