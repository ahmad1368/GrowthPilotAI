import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/business/build_invoice_pdf_document.dart';
import 'package:growth_pilot_ai/core/interfaces/invoice_pdf_service.dart';
import 'package:growth_pilot_ai/core/models/invoice_pdf_params.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local PDF assembly (Issue #146) — offloads the CPU-bound `pdf`
/// package build to `compute()`, mirroring [PdfDashboardExportService]
/// (#117).
class LocalInvoicePdfService implements InvoicePdfService {
  @override
  OmniResult<Uint8List> buildInvoicePdf(InvoicePdfParams params) async {
    try {
      final bytes = await compute(BuildInvoicePdfDocument.call, params);
      OmniLogger.info('Built invoice PDF (${params.invoiceNumber}, ${bytes.length}B)');
      return OmniResponse.success(bytes, message: 'Invoice ready');
    } catch (e, stack) {
      OmniLogger.error(
        title: 'Invoice PDF generation failed',
        widgetName: 'LocalInvoicePdfService',
        message: e,
        stackTrace: stack,
      );
      return OmniResponse.error('Could not build the invoice PDF');
    }
  }
}
