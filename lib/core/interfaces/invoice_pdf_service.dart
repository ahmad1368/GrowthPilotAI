import 'dart:typed_data';

import 'package:growth_pilot_ai/core/models/invoice_pdf_params.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Assembles a print-ready invoice PDF (Issue #146), mirroring
/// [DashboardExportService] (#117)'s swappable-renderer shape.
abstract class InvoicePdfService {
  OmniResult<Uint8List> buildInvoicePdf(InvoicePdfParams params);
}
