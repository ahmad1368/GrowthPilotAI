import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_basic_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_pricing_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful listing composer form for [showAssetDialog] (Issue #412).
class AssetDialogContent extends StatefulWidget {
  const AssetDialogContent({super.key});

  @override
  State<AssetDialogContent> createState() => _AssetDialogContentState();
}

class _AssetDialogContentState extends State<AssetDialogContent> {
  final _form = AssetFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('List Equipment/Asset'),
      description: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssetBasicFields(form: _form),
            const SizedBox(height: 8),
            AssetPricingFields(form: _form),
          ],
        ),
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Submit for Review')),
      ],
    );
  }
}
