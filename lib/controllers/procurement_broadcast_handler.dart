import 'package:growth_pilot_ai/business/build_procurement_notification.dart';
import 'package:growth_pilot_ai/business/build_procurement_request.dart';
import 'package:growth_pilot_ai/business/compute_business_rating_average.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/business/find_eligible_procurement_providers.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/block_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_request_repository.dart';

/// "Broadcast Logic" (Issue #126): creates the request, finds eligible
/// providers, and pushes a "Market Opportunity" alert to each — kept out
/// of [ProcurementController] to stay under the 50-line file limit.
class ProcurementBroadcastHandler {
  final ProcurementRequestRepository requests;
  final CatalogListingRepository listings;
  final BlockRepository blocks;
  final BusinessRatingRepository ratings;
  final InboxNotificationRepository notifications;
  final DispatchNotificationUseCase dispatch;

  ProcurementBroadcastHandler(this.requests, this.listings, this.blocks, this.ratings,
      this.notifications, this.dispatch);

  double get _globalAverageRating {
    final all = ratings.getAll();
    if (all.isEmpty) return 3.8;
    final sum = all.map(ComputeBusinessRatingAverage.call).reduce((a, b) => a + b);
    return sum / all.length;
  }

  Future<ProcurementRequestEntity> broadcast({
    required String requesterId,
    required String sector,
    required String summary,
    required double budgetMin,
    required double budgetMax,
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    required DateTime deadline,
  }) async {
    final now = DateTime.now();
    final request = BuildProcurementRequest.call(
        requesterId: requesterId, sector: sector, summary: summary, budgetMin: budgetMin,
        budgetMax: budgetMax, centerLat: centerLat, centerLng: centerLng, radiusKm: radiusKm,
        deadline: deadline, now: now);
    request.id = requests.insert(request);

    final providers = FindEligibleProcurementProviders.call(
        request: request, listings: listings, blocks: blocks, ratings: ratings,
        globalAverageRating: _globalAverageRating, now: now);
    for (final _ in providers) {
      final notification = BuildProcurementNotification.call(request, now);
      notifications.upsert(notification);
      await dispatch.dispatch(notification, notifications.getAll());
    }
    return request;
  }
}
