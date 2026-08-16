import 'package:flutter/foundation.dart';

/// One message in the Floating Financial Assistant chat (Issue #200).
@immutable
class ChatMessage {
  final String id;
  final bool isFromUser;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.isFromUser,
    required this.text,
    required this.createdAt,
  });

  ChatMessage copyWith({String? text}) =>
      ChatMessage(id: id, isFromUser: isFromUser, text: text ?? this.text, createdAt: createdAt);
}
