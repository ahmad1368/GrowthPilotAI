import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/response_verification.dart';

/// One message in the Floating Financial Assistant chat (Issue #200) —
/// [verification] is set on assistant messages once Issue #203's
/// guardrail finishes checking the streamed reply.
@immutable
class ChatMessage {
  final String id;
  final bool isFromUser;
  final String text;
  final DateTime createdAt;
  final ResponseVerification? verification;

  const ChatMessage({
    required this.id,
    required this.isFromUser,
    required this.text,
    required this.createdAt,
    this.verification,
  });

  ChatMessage copyWith({String? text, ResponseVerification? verification}) => ChatMessage(
        id: id,
        isFromUser: isFromUser,
        text: text ?? this.text,
        createdAt: createdAt,
        verification: verification ?? this.verification,
      );
}
