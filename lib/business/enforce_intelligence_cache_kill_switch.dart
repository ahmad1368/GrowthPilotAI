import 'package:growth_pilot_ai/business/should_wipe_intelligence_cache.dart';
import 'package:growth_pilot_ai/business/verify_intelligence_cache_integrity.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// Runs the "Auto-Wipe Policy" Kill Switch (Issue #106 scope item 4)
/// against the whole cache: any row failing integrity verification
/// counts as one tampering strike; past [ShouldWipeIntelligenceCache]'s
/// threshold the entire cache — and its encryption key — is wiped so no
/// stored ciphertext is ever recoverable again. Returns whether a wipe
/// happened.
class EnforceIntelligenceCacheKillSwitch {
  int _consecutiveFailures = 0;

  Future<bool> call(IntelligenceCacheRepository repo, FieldCipher cipher) async {
    final all = repo.getAll();
    final tampered = all.any((e) => !VerifyIntelligenceCacheIntegrity.call(e));

    if (!tampered) {
      _consecutiveFailures = 0;
      return false;
    }

    _consecutiveFailures++;
    if (!ShouldWipeIntelligenceCache.call(_consecutiveFailures)) return false;

    repo.removeAll(all);
    await cipher.deleteKey();
    _consecutiveFailures = 0;
    return true;
  }
}
