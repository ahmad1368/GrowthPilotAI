import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/models/dashboard_template.dart';

/// Drives the "Template Store" gallery (Issue #118): applying an archetype
/// backs up the user's current "Custom" layout first, then overwrites
/// [WidgetLayoutController]'s state with the template's — restorable via
/// [restoreCustom].
class DashboardTemplateController extends GetxController {
  final WidgetLayoutController _layoutController;
  final DashboardTemplateStore _backupStore;
  DashboardTemplateController(this._layoutController, this._backupStore);

  final appliedTemplateId = RxnString();

  Future<void> apply(DashboardTemplate template) async {
    await _backupStore.backupLayout(_layoutController.layout);
    await _layoutController.setLayout(template.layout);
    appliedTemplateId.value = template.id;
  }

  Future<void> restoreCustom() async {
    final backup = await _backupStore.loadBackup();
    if (backup == null) return;
    await _layoutController.setLayout(backup);
    appliedTemplateId.value = null;
  }
}
