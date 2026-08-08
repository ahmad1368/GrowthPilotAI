import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';
import 'package:growth_pilot_ai/core/models/invoice_line_item.dart';

/// "Breakdown of goods/services" (Issue #146) — a single line item from
/// the accepted procurement quote, since there's no multi-line cart
/// concept in this app's procurement flow yet.
class BuildInvoiceLineItems {
  static List<InvoiceLineItem> call(
      ProcurementRequestEntity request, ProcurementResponseEntity acceptedResponse) {
    return [
      (description: '${request.sector}: ${request.summary}', amount: acceptedResponse.quoteAmount ?? 0),
    ];
  }
}
