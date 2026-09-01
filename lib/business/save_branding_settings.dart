import 'dart:typed_data';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/branding_settings_repository.dart';

/// Persists the "Branding Configuration" screen's company name, brand
/// color, and optional logo bytes (Issue #257) as the single local
/// branding row consumed by [BuildPdfBrandingHeaderWidget].
class SaveBrandingSettings {
  static void call({
    required String companyName,
    required String brandColorHex,
    required Uint8List? logoBytes,
    required DateTime now,
  }) {
    GetIt.I<BrandingSettingsRepository>().save(BrandingSettingsEntity(
      companyName: companyName.trim(),
      brandColorHex: brandColorHex,
      logoBytes: logoBytes,
      updatedAt: now,
    ));
  }
}
