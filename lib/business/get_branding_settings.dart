import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/branding_settings_repository.dart';

/// Reads the current (single-row) branding settings, or null if the
/// user has never saved any (Issue #257).
class GetBrandingSettings {
  static BrandingSettingsEntity? call() => GetIt.I<BrandingSettingsRepository>().get();
}
