import 'package:growth_pilot_ai/business/obfuscate_location_to_neighborhood.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// Builds a Procurement Request broadcast (Issue #126), obfuscating the
/// requester's precise location before it's ever stored publicly.
class BuildProcurementRequest {
  static ProcurementRequestEntity call({
    required String requesterId,
    required String sector,
    required String summary,
    required double budgetMin,
    required double budgetMax,
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    required DateTime deadline,
    required DateTime now,
  }) {
    return ProcurementRequestEntity(
      requesterId: requesterId,
      sector: sector,
      summary: summary,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
      centerLat: centerLat,
      centerLng: centerLng,
      radiusKm: radiusKm,
      neighborhood: ObfuscateLocationToNeighborhood.call(centerLat, centerLng),
      deadline: deadline,
      createdAt: now,
    );
  }
}
