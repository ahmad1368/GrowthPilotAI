import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/confirm_stock_reservation.dart';
import 'package:growth_pilot_ai/business/release_stock_reservation.dart';
import 'package:growth_pilot_ai/business/reserve_stock_for_checkout.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_section.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_view.dart';

/// State for [StockReservationSection] (Issue #445): real-time lock CRUD.
class StockReservationSectionState extends State<StockReservationSection> {
  late List<StockReservationEntity> _reservations = widget.initialReservations;

  void _fail(String? message) {
    if (!mounted) return;
    final bar = SnackBar(content: Text(message ?? 'Action failed.'));
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }
  void _drop(int id) =>
      setState(() => _reservations = _reservations.where((r) => r.id != id).toList());

  Future<void> _reserve() async {
    final draft = await showStockReservationDialog(context, widget.items);
    if (draft == null) return;
    final store = Get.find<ObjectBox>().store;
    final result = await ReserveStockForCheckout.call(store, draft.item.id, draft.quantity);
    if (!result.success) return _fail(result.message);
    setState(() => _reservations = [..._reservations, result.data!]);
  }

  Future<void> _confirm(StockReservationEntity r) async {
    final res = await ConfirmStockReservation.call(Get.find<ObjectBox>().store, r.id);
    res.success ? _drop(r.id) : _fail(res.message);
  }

  Future<void> _release(StockReservationEntity r) async {
    final res = await ReleaseStockReservation.call(Get.find<ObjectBox>().store, r.id);
    res.success ? _drop(r.id) : _fail(res.message);
  }

  @override
  Widget build(BuildContext context) => StockReservationView(
        reservations: _reservations,
        onReserve: _reserve,
        onConfirm: _confirm,
        onRelease: _release,
      );
}
