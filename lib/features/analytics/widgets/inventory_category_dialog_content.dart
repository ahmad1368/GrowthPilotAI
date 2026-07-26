import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_inventory_category_path.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showInventoryCategoryDialog] (Issue #436): name
/// + optional parent picker for a nested category.
class InventoryCategoryDialogContent extends StatefulWidget {
  final List<InventoryCategoryEntity> existingCategories;

  const InventoryCategoryDialogContent({super.key, required this.existingCategories});

  @override
  State<InventoryCategoryDialogContent> createState() =>
      _InventoryCategoryDialogContentState();
}

class _InventoryCategoryDialogContentState extends State<InventoryCategoryDialogContent> {
  final _nameController = TextEditingController();
  InventoryCategoryEntity? _parent;

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final category = InventoryCategoryEntity(name: name);
    if (_parent != null) category.parent.target = _parent;
    Navigator.of(context).pop(category);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Add Category'),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInput(placeholder: const Text('Category name'), controller: _nameController),
          const SizedBox(height: 8),
          ShadSelect<InventoryCategoryEntity?>(
            initialValue: _parent,
            placeholder: const Text('Parent category (optional)'),
            options: [
              const ShadOption(value: null, child: Text('None')),
              for (final c in widget.existingCategories)
                ShadOption(value: c, child: Text(BuildInventoryCategoryPath.call(c))),
            ],
            selectedOptionBuilder: (context, value) =>
                Text(value == null ? 'None' : BuildInventoryCategoryPath.call(value)),
            onChanged: (value) => setState(() => _parent = value),
          ),
        ],
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
