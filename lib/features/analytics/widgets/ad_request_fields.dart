import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/recommend_ad_package.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Merchant name/category fields plus the auto-recommended package for
/// a new advertising request (Issue #401) — the needs-assessment
/// engine's recommendation updates live as the category is typed.
class AdRequestFields extends StatelessWidget {
  final TextEditingController merchantNameController;
  final TextEditingController categoryController;
  final AdPackageType selectedPackage;
  final ValueChanged<AdPackageType> onPackageChanged;
  final VoidCallback onCategoryChanged;

  const AdRequestFields({
    super.key,
    required this.merchantNameController,
    required this.categoryController,
    required this.selectedPackage,
    required this.onPackageChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Merchant name'),
            controller: merchantNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Category (e.g. Grocery, Bicycle Repair)'),
            controller: categoryController,
            onChanged: (_) => onCategoryChanged()),
        const SizedBox(height: 8),
        Text('Recommended: ${RecommendAdPackage.call(categoryController.text).name}',
            style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          for (final type in AdPackageType.values)
            if (selectedPackage == type)
              ShadButton(onPressed: () => onPackageChanged(type), child: Text(type.name))
            else
              ShadButton.outline(
                  onPressed: () => onPackageChanged(type), child: Text(type.name)),
        ]),
      ],
    );
  }
}
