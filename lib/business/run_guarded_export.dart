import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Shared error-handling wrapper for export/share actions (Issue
/// #254) — mirrors this repo's pre-existing #117
/// `DashboardExportController._guarded` pattern (duplicate-tap guard +
/// caught failure + `OmniLogger`), which the Traceability export
/// mixins had never adopted. The honest local stand-in for the
/// issue's "worker catches render failures and notifies the app so
/// the user isn't left waiting indefinitely."
class RunGuardedExport {
  static Future<void> call(
    RxBool isBusy,
    String kind,
    String widgetName,
    Future<void> Function() action,
  ) async {
    if (isBusy.value) return;
    isBusy.value = true;
    try {
      await action();
    } catch (e, stack) {
      OmniLogger.error(title: '$kind export failed', widgetName: widgetName, message: e, stackTrace: stack);
      Get.snackbar('Export failed', 'Could not complete the $kind export. Please try again.');
    } finally {
      isBusy.value = false;
    }
  }
}
