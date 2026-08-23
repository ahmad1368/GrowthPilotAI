import 'dart:convert';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_totp_provisioning_uri.dart';
import 'package:growth_pilot_ai/business/generate_totp_secret.dart';
import 'package:growth_pilot_ai/business/record_security_audit_event.dart';
import 'package:growth_pilot_ai/business/verify_totp_code.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Drives TOTP-based 2FA enrollment/verification (Issue #317 feature
/// #3) — no SMS/email backend exists in this local-first app, so an
/// authenticator app is the only channel.
class TwoFactorAuthController extends GetxController {
  static const _secretKey = 'totp_secret_v1';

  final isEnabled = false.obs;
  final Rxn<List<int>> pendingSecret = Rxn<List<int>>();

  @override
  void onInit() {
    super.onInit();
    _loadState();
  }

  Future<void> _loadState() async {
    isEnabled.value = await SecureStorageService.readData(_secretKey) != null;
  }

  String startEnrollment() {
    final secret = GenerateTotpSecret.call();
    pendingSecret.value = secret;
    return BuildTotpProvisioningUri.call(secretBytes: secret, accountName: 'local-user');
  }

  Future<bool> confirmEnrollment(String code) async {
    final secret = pendingSecret.value;
    if (secret == null || !VerifyTotpCode.call(secret, code, DateTime.now())) return false;

    await SecureStorageService.writeData(_secretKey, base64Encode(secret));
    pendingSecret.value = null;
    isEnabled.value = true;
    RecordSecurityAuditEvent.call(
        SecurityAuditActionType.twoFactorEnabled, SecurityAuditStatus.success, DateTime.now());
    return true;
  }

  Future<void> disable() async {
    await SecureStorageService.deleteData(_secretKey);
    isEnabled.value = false;
    RecordSecurityAuditEvent.call(
        SecurityAuditActionType.twoFactorDisabled, SecurityAuditStatus.success, DateTime.now());
  }
}
