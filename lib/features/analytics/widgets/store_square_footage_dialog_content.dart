import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-edit form body for the store's floor space (Issue #398). Returns
/// the entered square footage, or null if cancelled/invalid.
class StoreSquareFootageDialogContent extends StatefulWidget {
  final double initialSquareFootage;

  const StoreSquareFootageDialogContent({super.key, required this.initialSquareFootage});

  @override
  State<StoreSquareFootageDialogContent> createState() =>
      _StoreSquareFootageDialogContentState();
}

class _StoreSquareFootageDialogContentState extends State<StoreSquareFootageDialogContent> {
  late final _controller = TextEditingController(
      text: widget.initialSquareFootage > 0 ? widget.initialSquareFootage.toString() : '');

  void _submit() {
    final value = double.tryParse(_controller.text.trim());
    if (value == null || value <= 0) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Set Store Floor Space'),
      description: ShadInput(
        placeholder: const Text('Square footage'),
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
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
