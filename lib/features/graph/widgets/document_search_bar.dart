import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/document_search_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Semantic Search across all project documents" input (Issue #230).
class DocumentSearchBar extends StatefulWidget {
  final DocumentSearchController controller;

  const DocumentSearchBar({super.key, required this.controller});

  @override
  State<DocumentSearchBar> createState() => _DocumentSearchBarState();
}

class _DocumentSearchBarState extends State<DocumentSearchBar> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadInput(
            controller: _textController,
            placeholder: const Text('Search your documents...'),
            onSubmitted: (_) => widget.controller.search(_textController.text),
          ),
        ),
        const SizedBox(width: 8),
        ShadButton(
          onPressed: () => widget.controller.search(_textController.text),
          child: const Text('Search'),
        ),
      ],
    );
  }
}
