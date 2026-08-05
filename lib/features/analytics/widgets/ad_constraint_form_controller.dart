import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';

/// Holds the constraint form's selection and numeric-cap controllers
/// (Issue #409) — split out of [AdConstraintDialogContent].
class AdConstraintFormController {
  final List<AdvertisingRequestEntity> unconstrained;
  AdvertisingRequestEntity? selected;
  final days = TextEditingController(text: '7');
  final impressions = TextEditingController(text: '1000');
  final clicks = TextEditingController(text: '100');

  AdConstraintFormController(this.unconstrained) {
    selected = unconstrained.isEmpty ? null : unconstrained.first;
  }

  bool get isValid => selected != null;

  ({int requestId, int days, int impressions, int clicks}) build() {
    return (
      requestId: selected!.id,
      days: int.tryParse(days.text)?.clamp(1, 365) ?? 7,
      impressions: int.tryParse(impressions.text)?.clamp(1, 1000000) ?? 1000,
      clicks: int.tryParse(clicks.text)?.clamp(1, 1000000) ?? 100,
    );
  }
}
