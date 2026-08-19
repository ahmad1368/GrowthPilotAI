import 'dart:convert';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/share_pdf_bytes.dart';
import 'package:growth_pilot_ai/business/share_xlsx_bytes.dart';
import 'package:growth_pilot_ai/business/should_expire_export_asset.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "The exported file remains accessible even if the app is closed"
/// (Issue #253) — lists every locally-retained [ExportEventEntity]
/// (Issue #250's audit log, now also carrying bytes) and lets the
/// user re-share one within its 48h retention window, the honest
/// client-side stand-in for S3 + a presigned download URL.
class ExportHistoryController extends GetxController {
  ExportHistoryController(this._repository);

  final ExportEventRepository _repository;

  final events = <ExportEventEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshEvents();
  }

  void refreshEvents() => events.assignAll(_repository.getAll());

  bool isExpired(ExportEventEntity event) =>
      event.fileBytes == null || ShouldExpireExportAsset.call(event.occurredAt, DateTime.now());

  Future<void> reshare(ExportEventEntity event) async {
    final bytes = event.fileBytes;
    if (bytes == null || isExpired(event)) return;
    try {
      switch (event.format) {
        case 'xlsx':
          await ShareXlsxBytes.call(bytes, event.filename);
          break;
        case 'csv':
          await ShareCsvBytes.call(utf8.decode(bytes), event.filename);
          break;
        case 'pdf':
          await SharePdfBytes.call(bytes, event.filename);
          break;
      }
    } catch (e, stack) {
      OmniLogger.error(
          title: 'Export history re-share failed',
          widgetName: 'ExportHistoryController',
          message: e,
          stackTrace: stack);
    }
  }
}
