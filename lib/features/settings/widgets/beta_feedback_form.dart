import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "High-speed form (Rating 1-5 + Text Comment)" bypassing the
/// standard support ticket system (Issue #191) — not yet wired to an
/// automatic trigger (after the 3rd invoice scan / 1st marketplace
/// match); see [ShouldPromptBetaFeedback] and PR notes.
class BetaFeedbackForm extends StatefulWidget {
  final void Function(int rating, String comment) onSubmit;

  const BetaFeedbackForm({super.key, required this.onSubmit});

  @override
  State<BetaFeedbackForm> createState() => _BetaFeedbackFormState();
}

class _BetaFeedbackFormState extends State<BetaFeedbackForm> {
  final _commentController = TextEditingController();
  int _rating = 5;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: List.generate(5, (i) {
          final value = i + 1;
          return IconButton(
            icon: Icon(value <= _rating ? Icons.star_rounded : Icons.star_border_rounded, color: colors.primary),
            onPressed: () => setState(() => _rating = value),
          );
        }),
      ),
      const SizedBox(height: 8),
      ShadInput(controller: _commentController, placeholder: const Text('What should we improve?')),
      const SizedBox(height: 12),
      ShadButton(
        onPressed: () => widget.onSubmit(_rating, _commentController.text),
        child: const Text('Send Feedback'),
      ),
    ]);
  }
}
