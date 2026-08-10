import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/peer_group_scope.dart';

/// Result of [FindPeerGroup] (Issue #97) — [scope] is null when even the
/// broadest zoom level couldn't reach k members (the "Insufficient Data"
/// fallback AC), in which case [peers] is always empty.
@immutable
class PeerGroupResult {
  final List<AnonymizedListingEntity> peers;
  final PeerGroupScope? scope;

  const PeerGroupResult({required this.peers, required this.scope});

  bool get isSufficient => scope != null;

  /// "Confidence Score" metadata (Issue #97 scope item 4), e.g. "Based on
  /// 50+ similar items in your neighborhood".
  int get confidenceCount => peers.length;
}
