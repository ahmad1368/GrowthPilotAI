import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showBannerRuleDialog] (Issue #403): when
/// [existing] is provided the fields are pre-filled and its `id` is
/// preserved so saving updates the same rule in place.
class BannerRuleDialogContent extends StatefulWidget {
  final BannerMatchingRuleEntity? existing;

  const BannerRuleDialogContent({super.key, this.existing});

  @override
  State<BannerRuleDialogContent> createState() => _BannerRuleDialogContentState();
}

class _BannerRuleDialogContentState extends State<BannerRuleDialogContent> {
  late final _reportTopicController =
      TextEditingController(text: widget.existing?.reportTopic);
  late final _categoryController = TextEditingController(text: widget.existing?.category);
  late final _priorityWeightController =
      TextEditingController(text: widget.existing?.priorityWeight.toString());

  void _submit() {
    final priorityWeight = int.tryParse(_priorityWeightController.text);
    if (_reportTopicController.text.trim().isEmpty ||
        _categoryController.text.trim().isEmpty ||
        priorityWeight == null ||
        priorityWeight < 0) {
      return;
    }
    Navigator.of(context).pop(BannerMatchingRuleEntity(
      id: widget.existing?.id ?? 0,
      reportTopic: _reportTopicController.text.trim(),
      category: _categoryController.text.trim(),
      priorityWeight: priorityWeight,
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: Text(widget.existing == null ? 'Add Matching Rule' : 'Edit Matching Rule'),
      description: BannerRuleFields(
        reportTopicController: _reportTopicController,
        categoryController: _categoryController,
        priorityWeightController: _priorityWeightController,
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
