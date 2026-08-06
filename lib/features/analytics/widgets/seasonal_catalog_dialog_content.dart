import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_basic_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_terms_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful catalog-line composer form for
/// [showSeasonalCatalogDialog] (Issue #417).
class SeasonalCatalogDialogContent extends StatefulWidget {
  const SeasonalCatalogDialogContent({super.key});

  @override
  State<SeasonalCatalogDialogContent> createState() => _SeasonalCatalogDialogContentState();
}

class _SeasonalCatalogDialogContentState extends State<SeasonalCatalogDialogContent> {
  final _form = SeasonalCatalogFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('List Seasonal Catalog Line'),
      description: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeasonalCatalogBasicFields(form: _form),
            const SizedBox(height: 8),
            SeasonalCatalogTermsFields(form: _form),
          ],
        ),
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Publish Line')),
      ],
    );
  }
}
