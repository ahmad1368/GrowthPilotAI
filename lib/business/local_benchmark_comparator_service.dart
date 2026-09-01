import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/business/compute_local_benchmark.dart';
import 'package:growth_pilot_ai/business/decrypt_intelligence_cache_snapshot.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/models/local_benchmark_params.dart';
import 'package:growth_pilot_ai/core/models/local_benchmark_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// On-device "mini-server" (Issue #107): benchmarks one item against its
/// #106-encrypted local peers, zero network round-trip. Decryption stays
/// on the root isolate (required by `flutter_secure_storage`'s platform
/// channel); the percentile math then runs inside `compute()` so a large
/// cache never drops UI frames.
class LocalBenchmarkComparatorService {
  final IntelligenceCacheRepository _repo;
  final FieldCipher _cipher;

  LocalBenchmarkComparatorService(this._repo, this._cipher);

  OmniResult<LocalBenchmarkResult> compareAgainstSectorPeers(
    String itemId,
    String sectorId,
    double? targetPricePosition,
  ) async {
    try {
      final peers = _repo.getAll().where((e) => e.sectorId == sectorId && e.itemId != itemId);
      final pricePositions = <double>[];
      for (final peer in peers) {
        final position = (await DecryptIntelligenceCacheSnapshot.call(peer, _cipher)).pricePosition;
        if (position != null) pricePositions.add(position);
      }

      final params = LocalBenchmarkParams(
          targetPricePosition: targetPricePosition, peerPricePositions: pricePositions);
      return OmniResponse.success(await compute(ComputeLocalBenchmark.call, params));
    } catch (e, stack) {
      OmniLogger.error(
        title: 'Local benchmark comparison failed',
        widgetName: 'LocalBenchmarkComparatorService',
        message: e,
        stackTrace: stack,
      );
      return OmniResponse.error('Could not compute the local benchmark');
    }
  }
}
