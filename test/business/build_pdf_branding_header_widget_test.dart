import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_pdf_branding_header_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  group('BuildPdfBrandingHeaderWidget', () {
    Future<void> expectRendersWithoutThrowing(BrandingSettingsEntity? settings) async {
      final doc = pw.Document();
      doc.addPage(pw.Page(build: (context) => BuildPdfBrandingHeaderWidget.call(settings)));
      final bytes = await doc.save();
      expect(bytes, isNotEmpty);
    }

    test('falls back to the default GrowthPilotAI header when settings is null', () async {
      await expectRendersWithoutThrowing(null);
    });

    test('falls back to the default header when the company name is empty', () async {
      await expectRendersWithoutThrowing(
        BrandingSettingsEntity(companyName: '', brandColorHex: '#2563EB', updatedAt: DateTime(2026, 1, 1)),
      );
    });

    test('renders the company name with a valid brand color and no logo', () async {
      await expectRendersWithoutThrowing(
        BrandingSettingsEntity(companyName: 'Acme Consulting', brandColorHex: '#DC2626', updatedAt: DateTime(2026, 1, 1)),
      );
    });

    test('renders with an invalid brand-color hex without throwing (falls back to default color)', () async {
      await expectRendersWithoutThrowing(
        BrandingSettingsEntity(companyName: 'Acme Consulting', brandColorHex: 'not-a-color', updatedAt: DateTime(2026, 1, 1)),
      );
    });

    test('renders with a logo image', () async {
      await expectRendersWithoutThrowing(BrandingSettingsEntity(
        companyName: 'Acme Consulting',
        brandColorHex: '#059669',
        logoBytes: base64Decode(
            'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII='),
        updatedAt: DateTime(2026, 1, 1),
      ));
    });
  });
}
