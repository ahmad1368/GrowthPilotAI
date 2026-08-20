import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_export_saved_message.dart';
import 'package:growth_pilot_ai/business/save_export_bytes_to_downloads.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "Completion Notification: trigger Haptic Feedback and a SnackBar"
/// (Issue #255) — best-effort: a failed Downloads write never breaks
/// the already-successful share/export it's attached to.
class NotifyExportSaved {
  static Future<void> call(Uint8List bytes, String filename) async {
    var savedToDownloads = false;
    try {
      savedToDownloads = await SaveExportBytesToDownloads.call(bytes, filename) != null;
    } catch (e, stack) {
      OmniLogger.error(
          title: 'Saving export to Downloads failed',
          widgetName: 'NotifyExportSaved',
          message: e,
          stackTrace: stack);
    }
    HapticFeedback.mediumImpact();
    Get.snackbar('Export ready', BuildExportSavedMessage.call(filename, savedToDownloads: savedToDownloads));
  }
}
