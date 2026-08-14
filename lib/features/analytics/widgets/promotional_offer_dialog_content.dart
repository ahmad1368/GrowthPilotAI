import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showPromotionalOfferDialog] (Issue #335):
/// owns the text controllers for the new dispatch.
class PromotionalOfferDialogContent extends StatefulWidget {
  const PromotionalOfferDialogContent({super.key});

  @override
  State<PromotionalOfferDialogContent> createState() =>
      _PromotionalOfferDialogContentState();
}

class _PromotionalOfferDialogContentState
    extends State<PromotionalOfferDialogContent> {
  final _offerTextController = TextEditingController();
  final _targetFilterController = TextEditingController();
  final _sentCountController = TextEditingController();
  final _openedCountController = TextEditingController();
  final _usedCountController = TextEditingController();

  void _submit() {
    final sent = int.tryParse(_sentCountController.text);
    final opened = int.tryParse(_openedCountController.text);
    final used = int.tryParse(_usedCountController.text);
    if (_offerTextController.text.trim().isEmpty ||
        _targetFilterController.text.trim().isEmpty ||
        sent == null ||
        sent < 0 ||
        opened == null ||
        opened < 0 ||
        used == null ||
        used < 0) {
      return;
    }
    Navigator.of(context).pop(PromotionalOfferEntity(
      offerText: _offerTextController.text.trim(),
      targetFilter: _targetFilterController.text.trim(),
      sentCount: sent,
      openedCount: opened,
      usedCount: used,
      dispatchedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Offer Dispatch'),
      description: PromotionalOfferFields(
        offerTextController: _offerTextController,
        targetFilterController: _targetFilterController,
        sentCountController: _sentCountController,
        openedCountController: _openedCountController,
        usedCountController: _usedCountController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
