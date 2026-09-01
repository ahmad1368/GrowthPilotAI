import 'dart:convert';

import 'package:growth_pilot_ai/core/models/distilled_context.dart';

/// Canonical JSON for one item's [DistilledContext] (Issue #106) — the
/// exact plaintext both hashed into `contentHash` (cheap delta
/// comparison) and AES-encrypted into `encryptedSnapshot`, so a
/// byte-identical snapshot always hashes identically.
class BuildIntelligenceCacheSnapshotJson {
  static String call(DistilledContext context) => jsonEncode({
        'marketTemperature': context.marketTemperature.index,
        'pricePosition': context.pricePosition,
        'scarcityIndex': context.scarcityIndex,
        'isHiddenGem': context.isHiddenGem,
      });
}
