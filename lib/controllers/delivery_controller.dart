import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_delivery_entity.dart';
import 'package:growth_pilot_ai/controllers/delivery_handshake_handler.dart';
import 'package:growth_pilot_ai/controllers/delivery_location_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_handshake_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_location_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/payment_repository.dart';

/// "Advanced Logistics & Proof of Delivery" (Issue #155): live-location
/// bookkeeping, ETA estimation, and the QR handshake that releases the
/// #147 escrow. Native GPS tracking, the Maps overlay, and camera-based
/// PoD capture are UI/platform follow-ups — see the PR notes.
class DeliveryController extends GetxController {
  late DeliveryRepository _deliveries;
  late DeliveryLocationHandler _locationHandler;
  late DeliveryHandshakeHandler _handshakeHandler;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _deliveries = DeliveryRepository(store.box());
    _locationHandler =
        DeliveryLocationHandler(_deliveries, DeliveryLocationHistoryRepository(store.box()));
    _handshakeHandler = DeliveryHandshakeHandler(
        _deliveries, DeliveryHandshakeRepository(store.box()), PaymentRepository(store.box()));
  }

  DeliveryEntity start(int requestId, int paymentId, String courierId, {required bool consentGiven}) {
    final delivery = BuildDeliveryEntity.call(requestId, paymentId, courierId,
        consentGiven: consentGiven, now: DateTime.now());
    delivery.id = _deliveries.upsert(delivery);
    return delivery;
  }

  double? recordLocation(DeliveryEntity delivery, double lat, double lng,
          {required double destLat, required double destLng}) =>
      _locationHandler.recordLocation(delivery, lat, lng, DateTime.now(),
          destLat: destLat, destLng: destLng);

  String generateHandshake(DeliveryEntity delivery) =>
      _handshakeHandler.generate(delivery, DateTime.now());

  bool completeWithHandshake(DeliveryEntity delivery, PaymentEntity payment, String scannedToken) =>
      _handshakeHandler.verifyAndComplete(delivery, payment, scannedToken, DateTime.now());
}
