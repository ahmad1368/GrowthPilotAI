import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/recommend_ad_package.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful self-service submission form for [showAdRequestDialog]
/// (Issue #401).
class AdRequestDialogContent extends StatefulWidget {
  const AdRequestDialogContent({super.key});

  @override
  State<AdRequestDialogContent> createState() => _AdRequestDialogContentState();
}

class _AdRequestDialogContentState extends State<AdRequestDialogContent> {
  final _merchantNameController = TextEditingController();
  final _categoryController = TextEditingController();
  AdPackageType? _manualPackage;

  void _submit() {
    if (_merchantNameController.text.trim().isEmpty ||
        _categoryController.text.trim().isEmpty) {
      return;
    }
    final package = _manualPackage ?? RecommendAdPackage.call(_categoryController.text);
    Navigator.of(context).pop(AdvertisingRequestEntity(
      merchantName: _merchantNameController.text.trim(),
      category: _categoryController.text.trim(),
      dbPackageType: package.index,
      requestedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final selected =
        _manualPackage ?? RecommendAdPackage.call(_categoryController.text);
    return ShadDialog.alert(
      title: const Text('Request Advertising Package'),
      description: AdRequestFields(
        merchantNameController: _merchantNameController,
        categoryController: _categoryController,
        selectedPackage: selected,
        onPackageChanged: (t) => setState(() => _manualPackage = t),
        onCategoryChanged: () => setState(() {}),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Submit')),
      ],
    );
  }
}
