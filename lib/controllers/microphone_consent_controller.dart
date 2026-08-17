import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/set_microphone_monitoring_consent.dart';
import 'package:growth_pilot_ai/core/data/repositories/microphone_consent_repository.dart';

/// Drives the mock "Microphone Audio Monitoring" consent toggle (Issue
/// #540) — no microphone permission is ever requested by this app; see
/// [MicrophoneMonitoringConsentToggle]'s doc comment for the full
/// disclosure.
class MicrophoneConsentController extends GetxController {
  final MicrophoneConsentRepository _repository;
  late final RxBool optedIn;

  MicrophoneConsentController(this._repository);

  @override
  void onInit() {
    super.onInit();
    optedIn = _repository.get().optedIn.obs;
  }

  void setOptedIn(bool value) {
    SetMicrophoneMonitoringConsent.call(value, DateTime.now());
    optedIn.value = value;
  }
}
