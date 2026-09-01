import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/core/models/response_verification.dart';

/// One message in the Floating Financial Assistant chat (Issue #200) —
/// [verification] is set once Issue #203's guardrail finishes checking
/// a streamed reply; [isHelpful]/[feedbackReason] are set once the user
/// taps a thumbs up/down (Issue #209).
@immutable
class ChatMessage {
  final String id;
  final bool isFromUser;
  final String text;
  final DateTime createdAt;
  final ResponseVerification? verification;
  final bool? isHelpful;
  final FeedbackReason? feedbackReason;

  const ChatMessage({
    required this.id,
    required this.isFromUser,
    required this.text,
    required this.createdAt,
    this.verification,
    this.isHelpful,
    this.feedbackReason,
  });

  ChatMessage copyWith(
          {String? text,
          ResponseVerification? verification,
          bool? isHelpful,
          FeedbackReason? feedbackReason}) =>
      ChatMessage(
        id: id,
        isFromUser: isFromUser,
        text: text ?? this.text,
        createdAt: createdAt,
        verification: verification ?? this.verification,
        isHelpful: isHelpful ?? this.isHelpful,
        feedbackReason: feedbackReason ?? this.feedbackReason,
      );
}
