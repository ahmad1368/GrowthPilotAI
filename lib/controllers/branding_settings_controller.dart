import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/get_branding_settings.dart';
import 'package:growth_pilot_ai/business/save_branding_settings.dart';

/// Drives the local "Branding Configuration" screen (Issue #257's
/// Flutter step) — company name, brand color, and logo are stored
/// locally and consumed directly by the traceability PDF header (see
/// `BuildPdfBrandingHeaderWidget`); no Node.js/S3 pipeline exists here
/// (see PR notes).
class BrandingSettingsController extends GetxController {
  late final RxString companyName;
  late final RxString brandColorHex;
  late final Rxn<Uint8List> logoBytes;

  @override
  void onInit() {
    super.onInit();
    final existing = GetBrandingSettings.call();
    companyName = (existing?.companyName ?? '').obs;
    brandColorHex = (existing?.brandColorHex ?? '#2563EB').obs;
    logoBytes = Rxn<Uint8List>(existing?.logoBytes);
  }

  void setBrandColor(String hex) => brandColorHex.value = hex;
  void setLogo(Uint8List? bytes) => logoBytes.value = bytes;

  void save() {
    SaveBrandingSettings.call(
      companyName: companyName.value,
      brandColorHex: brandColorHex.value,
      logoBytes: logoBytes.value,
      now: DateTime.now(),
    );
    Get.snackbar('Branding saved', 'Your PDF exports will now use this branding.');
  }
}
