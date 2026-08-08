import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/core/models/invoice_pdf_params.dart';

/// Assembles the invoice PDF (Issue #146: "professional... invoice that
/// includes the Business Registration Number, a breakdown of goods/
/// services"). A top-level-callable static method so the service can
/// run it off the UI thread via `compute()`, mirroring
/// [BuildDashboardPdfDocument] (#117).
class BuildInvoicePdfDocument {
  static Future<Uint8List> call(InvoicePdfParams p) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
      build: (context) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text('Invoice ${p.invoiceNumber}',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text(p.issuedAt.toIso8601String().split('T').first),
        ]),
        pw.SizedBox(height: 8),
        pw.Text('Sold by: ${p.sellerId}'
            '${p.sellerBusinessNumber != null ? " (BN ${p.sellerBusinessNumber})" : ""}'),
        pw.Text('Bill to: ${p.buyerId}'),
        pw.SizedBox(height: 12),
        for (final item in p.lineItems)
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Text(item.description),
            pw.Text('\$${item.amount.toStringAsFixed(2)}'),
          ]),
        pw.Divider(),
        _totalRow('Subtotal', p.subtotal),
        _totalRow('GST (5%)', p.gst),
        if (p.pst > 0) _totalRow('PST (7%)', p.pst),
        _totalRow('Total', p.total, bold: true),
        pw.SizedBox(height: 12),
        pw.Text('Retain for 7 years per CRA record-keeping requirements.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
      ]),
    ));
    return doc.save();
  }

  static pw.Widget _totalRow(String label, double amount, {bool bold = false}) {
    final style = bold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : const pw.TextStyle();
    return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(label, style: style),
      pw.Text('\$${amount.toStringAsFixed(2)}', style: style),
    ]);
  }
}
