import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/deserialize_utm_attribution.dart';
import 'package:growth_pilot_ai/business/parse_utm_parameters.dart';
import 'package:growth_pilot_ai/business/serialize_utm_attribution.dart';
import 'package:growth_pilot_ai/core/models/utm_attribution.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Captures LinkedIn/campaign attribution (Issue #192's "Lead Tracking &
/// Analytics") from the web landing URL's `?utm_source=...` query string
/// once at launch, then holds it until a Founding Member spot is claimed
/// — first-touch attribution across the signup funnel, not just the
/// final click. Web-only capture (`Uri.base` is meaningless on native).
class AcquisitionAttributionService extends GetxService {
  static const _storageKey = 'acquisition_attribution';
  UtmAttribution? current;

  @override
  void onInit() {
    super.onInit();
    if (kIsWeb) {
      _captureFromUrl();
    } else {
      _restore();
    }
  }

  Future<void> _captureFromUrl() async {
    final fromUrl = ParseUtmParameters.call(Uri.base.queryParameters);
    if (fromUrl == null) {
      await _restore();
      return;
    }
    current = fromUrl;
    await SecureStorageService.writeData(_storageKey, SerializeUtmAttribution.call(fromUrl));
  }

  Future<void> _restore() async {
    current = DeserializeUtmAttribution.call(await SecureStorageService.readData(_storageKey));
  }
}
