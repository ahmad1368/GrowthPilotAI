import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/estimate_translation_resource_cost.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';

/// One chat bubble with an original/translated toggle (Issue #430,
/// acceptance criteria 4-5).
class TranslationChatBubble extends StatefulWidget {
  final ChatMessageEntity message;
  const TranslationChatBubble({super.key, required this.message});

  @override
  State<TranslationChatBubble> createState() => _TranslationChatBubbleState();
}

class _TranslationChatBubbleState extends State<TranslationChatBubble> {
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.message;
    final fg = Theme.of(context).colorScheme.onSurface;
    final cost = EstimateTranslationResourceCost.call(m.originalText.split(' ').length);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: fg.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(m.senderName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        Text(_showOriginal ? m.originalText : m.translatedText, style: const TextStyle(fontSize: 13)),
        Row(children: [
          Expanded(
            child: Text(
              '${(m.translationConfidence * 100).toStringAsFixed(0)}% matched — '
              'on-device, ${cost.processingMicroseconds}µs',
              style: TextStyle(fontSize: 10, color: fg.withValues(alpha: 0.5)),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => _showOriginal = !_showOriginal),
            child: Text(_showOriginal ? 'Show translated' : 'Show original',
                style: const TextStyle(fontSize: 10)),
          ),
        ]),
      ]),
    );
  }
}
