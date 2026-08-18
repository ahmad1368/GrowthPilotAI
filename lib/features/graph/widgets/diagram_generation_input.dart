import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/diagram_generation_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The "type or paste a text description" input (Issue #224) — one step
/// per line, or `Step A -> Step B` lines for branching.
class DiagramGenerationInput extends StatefulWidget {
  final DiagramGenerationController controller;

  const DiagramGenerationInput({super.key, required this.controller});

  @override
  State<DiagramGenerationInput> createState() => _DiagramGenerationInputState();
}

class _DiagramGenerationInputState extends State<DiagramGenerationInput> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
          controller: _textController,
          placeholder: const Text('Submit request\nManager review\nApprove or reject'),
          maxLines: 6,
        ),
        const SizedBox(height: 8),
        ShadButton(
          onPressed: () => widget.controller.generate(_textController.text),
          child: const Text('Generate diagram'),
        ),
      ],
    );
  }
}
