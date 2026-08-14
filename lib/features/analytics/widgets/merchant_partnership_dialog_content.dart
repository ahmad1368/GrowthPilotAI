import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showMerchantPartnershipDialog] (Issue #393):
/// owns the text controllers and picked partnered date.
class MerchantPartnershipDialogContent extends StatefulWidget {
  const MerchantPartnershipDialogContent({super.key});

  @override
  State<MerchantPartnershipDialogContent> createState() =>
      _MerchantPartnershipDialogContentState();
}

class _MerchantPartnershipDialogContentState
    extends State<MerchantPartnershipDialogContent> {
  final _partnerNameController = TextEditingController();
  final _partnerCategoryController = TextEditingController();
  final _overlapScoreController = TextEditingController();
  final _campaignRevenueController = TextEditingController();
  final _referralCountController = TextEditingController();
  DateTime? _partneredAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _partneredAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _partneredAt = picked);
  }

  void _submit() {
    final overlapScore = double.tryParse(_overlapScoreController.text);
    final campaignRevenue = double.tryParse(_campaignRevenueController.text);
    final referralCount = int.tryParse(_referralCountController.text);
    if (_partnerNameController.text.trim().isEmpty ||
        _partnerCategoryController.text.trim().isEmpty ||
        overlapScore == null ||
        overlapScore < 0 ||
        overlapScore > 100 ||
        campaignRevenue == null ||
        campaignRevenue < 0 ||
        referralCount == null ||
        referralCount < 0 ||
        _partneredAt == null) {
      return;
    }
    Navigator.of(context).pop(MerchantPartnershipEntity(
      partnerBusinessName: _partnerNameController.text.trim(),
      partnerCategory: _partnerCategoryController.text.trim(),
      customerOverlapScore: overlapScore,
      jointCampaignRevenue: campaignRevenue,
      referralCount: referralCount,
      partneredAt: _partneredAt!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Merchant Partnership'),
      description: MerchantPartnershipFields(
        partnerNameController: _partnerNameController,
        partnerCategoryController: _partnerCategoryController,
        overlapScoreController: _overlapScoreController,
        campaignRevenueController: _campaignRevenueController,
        referralCountController: _referralCountController,
        partneredAt: _partneredAt,
        onPickDate: _pickDate,
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
