import 'package:growth_pilot_ai/core/utils/base32_encoder.dart';

/// Builds the `otpauth://totp/...` provisioning URI (Issue #317
/// feature #3) — the de facto "Google Authenticator Key URI Format"
/// every mainstream authenticator app parses for manual entry or QR
/// scanning (no QR image is rendered here; see PR notes).
class BuildTotpProvisioningUri {
  static String call({required List<int> secretBytes, required String accountName}) {
    final secret = Base32Encoder.encode(secretBytes);
    final label = Uri.encodeComponent('GrowthPilotAI:$accountName');
    return 'otpauth://totp/$label?secret=$secret&issuer=GrowthPilotAI&algorithm=SHA1&digits=6&period=30';
  }
}
