import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/ai_chat_controller.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/feedback_reason_chips.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/thumb_vote_row.dart';

/// Thumbs up/down under an AI message (Issue #209) — semi-transparent
/// until a vote is cast, then a "Selected" colored state (AC).
class FeedbackButtons extends StatefulWidget {
  final ChatMessage message;
  const FeedbackButtons({super.key, required this.message});

  @override
  State<FeedbackButtons> createState() => _FeedbackButtonsState();
}

class _FeedbackButtonsState extends State<FeedbackButtons> {
  bool _showReasons = false;

  void _vote(bool isHelpful) {
    if (!isHelpful) {
      setState(() => _showReasons = true);
      return;
    }
    Get.find<AiChatController>().submitFeedback(widget.message.id, true);
  }

  void _selectReason(FeedbackReason reason) {
    Get.find<AiChatController>().submitFeedback(widget.message.id, false, reason: reason);
    setState(() => _showReasons = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      ThumbVoteRow(isHelpful: widget.message.isHelpful, onVote: _vote),
      if (_showReasons) FeedbackReasonChips(onSelected: _selectReason),
    ]);
  }
}
