import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/business/expire_overdue_procurement_requests.dart';
import 'package:growth_pilot_ai/business/submit_procurement_response.dart';
import 'package:growth_pilot_ai/controllers/procurement_broadcast_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/block_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_response_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// Procurement Request broadcast/response flow (Issue #126); delegates
/// broadcast creation to [ProcurementBroadcastHandler] for SRP.
class ProcurementController extends GetxController {
  late ProcurementRequestRepository _requests;
  late ProcurementResponseRepository _responses;
  late ProcurementBroadcastHandler _broadcastHandler;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _requests = ProcurementRequestRepository(store.box());
    _responses = ProcurementResponseRepository(store.box());
    _broadcastHandler = ProcurementBroadcastHandler(
        _requests,
        CatalogListingRepository(store.box()),
        BlockRepository(store.box()),
        BusinessRatingRepository(store.box()),
        InboxNotificationRepository(store.box()),
        DependencyInjection.get<DispatchNotificationUseCase>());
  }

  Future<ProcurementRequestEntity> broadcastRequest({
    required String requesterId,
    required String sector,
    required String summary,
    required double budgetMin,
    required double budgetMax,
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    required DateTime deadline,
  }) =>
      _broadcastHandler.broadcast(
          requesterId: requesterId, sector: sector, summary: summary, budgetMin: budgetMin,
          budgetMax: budgetMax, centerLat: centerLat, centerLng: centerLng, radiusKm: radiusKm,
          deadline: deadline);

  List<ProcurementRequestEntity> openRequests() {
    final all = _requests.getAll();
    _requests.upsertAll(ExpireOverdueProcurementRequests.call(all, DateTime.now()));
    return all.where((r) => r.status == ProcurementRequestStatus.open).toList();
  }

  ProcurementResponseEntity respond({
    required int requestId,
    required String providerId,
    required String message,
    double? quoteAmount,
  }) {
    final response = SubmitProcurementResponse.call(
        requestId: requestId, providerId: providerId, message: message,
        quoteAmount: quoteAmount, now: DateTime.now());
    response.id = _responses.insert(response);
    return response;
  }

  List<ProcurementResponseEntity> responsesFor(int requestId) => _responses.getForRequest(requestId);

  void acceptResponse(int requestId) {
    final request = _requests.getById(requestId);
    if (request == null || request.status != ProcurementRequestStatus.open) return;
    request.status = ProcurementRequestStatus.accepted;
    _requests.insert(request);
  }
}
