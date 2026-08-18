import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Native BottomSheet opened on `onNodeDoubleClick` (Issue #220) — no
/// backend `PATCH /api/v1/projects/:id/canvas` exists to persist an
/// edit yet (see PR notes), so [Navigator.pop] just returns the edited
/// text to the caller for now.
class RequirementEditBottomSheet extends StatefulWidget {
  final String initialLabel;

  const RequirementEditBottomSheet({super.key, required this.initialLabel});

  @override
  State<RequirementEditBottomSheet> createState() => _RequirementEditBottomSheetState();
}

class _RequirementEditBottomSheetState extends State<RequirementEditBottomSheet> {
  late final _controller = TextEditingController(text: widget.initialLabel);

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit requirement', style: TextStyle(color: colors.foreground, fontSize: 16)),
          const SizedBox(height: 12),
          ShadInput(controller: _controller),
          const SizedBox(height: 12),
          ShadButton(
            onPressed: () => Navigator.of(context).pop(_controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
