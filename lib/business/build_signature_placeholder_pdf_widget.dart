import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// "Signature Placeholder: show a 'Sign Here' ghost-box" (Issue #259)
/// — a visual placeholder only; no real digital-signature capture
/// exists in this repo (see PR notes).
class BuildSignaturePlaceholderPdfWidget {
  static pw.Widget call() {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 24),
      padding: const pw.EdgeInsets.all(12),
      width: 220,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400, style: pw.BorderStyle.dashed),
      ),
      child: pw.Text('Sign Here', style: const pw.TextStyle(color: PdfColors.grey500, fontSize: 10)),
    );
  }
}
