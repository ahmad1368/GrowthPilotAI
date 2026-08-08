import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_invoice_entity.dart';
import 'package:growth_pilot_ai/business/build_invoice_line_items.dart';
import 'package:growth_pilot_ai/business/build_invoice_pdf_params_from_entity.dart';
import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/invoice_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_response_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/invoice_pdf_service.dart';

/// "Transaction-to-Invoice Pipeline" (Issue #146): turns an accepted
/// procurement quote into a persisted, PDF-backed [InvoiceEntity].
class InvoiceController extends GetxController {
  late InvoiceRepository _invoices;
  late ProcurementRequestRepository _requests;
  late ProcurementResponseRepository _responses;
  late InvoicePdfService _pdfService;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _invoices = InvoiceRepository(store.box());
    _requests = ProcurementRequestRepository(store.box());
    _responses = ProcurementResponseRepository(store.box());
    _pdfService = DependencyInjection.get<InvoicePdfService>();
  }

  Future<InvoiceEntity?> generateInvoice({
    required int requestId,
    required int responseId,
    String? sellerBusinessNumber,
    bool applyPst = true,
  }) async {
    final request = _requests.getById(requestId);
    final response = _responses.getForRequest(requestId).where((r) => r.id == responseId).firstOrNull;
    if (request == null || response == null) return null;

    final lineItems = BuildInvoiceLineItems.call(request, response);
    final subtotal = lineItems.fold(0.0, (sum, item) => sum + item.amount);

    final invoice = BuildInvoiceEntity.call(
        requestId: requestId,
        sellerId: response.providerId,
        buyerId: request.requesterId,
        sellerBusinessNumber: sellerBusinessNumber,
        subtotal: subtotal,
        tax: CalculateGstPst.call(subtotal, applyPst: applyPst),
        now: DateTime.now());
    invoice.id = _invoices.insert(invoice);

    final pdfResult = await _pdfService
        .buildInvoicePdf(BuildInvoicePdfParamsFromEntity.call(invoice, lineItems));
    if (!pdfResult.success || pdfResult.data == null) return null;

    invoice.pdfBytes = pdfResult.data!;
    _invoices.insert(invoice);
    return invoice;
  }
}
