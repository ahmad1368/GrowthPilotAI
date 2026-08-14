import 'dart:convert';

import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// Decrypts one cache row back into a [DistilledContext] (Issue #106) —
/// the "decrypted only at the moment of use" step the issue's own
/// Conceptual Overview describes for the Glassmorphism UI (#142).
class DecryptIntelligenceCacheSnapshot {
  static Future<DistilledContext> call(
    IntelligenceCacheEntryEntity entry,
    FieldCipher cipher,
  ) async {
    final plaintext = await cipher.decryptField(entry.encryptedSnapshot);
    final json = jsonDecode(plaintext) as Map<String, dynamic>;
    return DistilledContext(
      marketTemperature: MarketTemperature.values[json['marketTemperature'] as int],
      pricePosition: (json['pricePosition'] as num?)?.toDouble(),
      scarcityIndex: (json['scarcityIndex'] as num).toDouble(),
      isHiddenGem: json['isHiddenGem'] as bool,
    );
  }
}
