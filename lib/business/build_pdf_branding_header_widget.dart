import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';

/// The local render-time equivalent of Issue #257's server-side
/// "inject the user's brand color into the HTML/Handlebars template"
/// step — builds a small page header (logo + company name + brand
/// accent bar) from [settings] that
/// `BuildTraceabilityReportPdfDocument` stacks above the report
/// content. Falls back to a plain "GrowthPilotAI" header when
/// [settings] is null or has no company name, per the issue's own
/// "Always provide a clean, professional default... for users who
/// don't upload a logo" note.
class BuildPdfBrandingHeaderWidget {
  static pw.Widget call(BrandingSettingsEntity? settings) {
    final color = _parseHexColor(settings?.brandColorHex);
    final logoBytes = settings?.logoBytes;
    final name = (settings?.companyName.isNotEmpty ?? false) ? settings!.companyName : 'GrowthPilotAI';

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 8),
      margin: const pw.EdgeInsets.only(bottom: 12),
      decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: color, width: 2))),
      child: pw.Row(children: [
        if (logoBytes != null)
          pw.Container(
            width: 28,
            height: 28,
            margin: const pw.EdgeInsets.only(right: 8),
            child: pw.Image(pw.MemoryImage(logoBytes)),
          ),
        pw.Text(name, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: color)),
      ]),
    );
  }

  static PdfColor _parseHexColor(String? hex) {
    final cleaned = hex?.replaceFirst('#', '');
    final value = cleaned == null ? null : int.tryParse(cleaned, radix: 16);
    if (value == null) return PdfColors.blueGrey800;
    return PdfColor.fromInt(0xFF000000 | value);
  }
}
