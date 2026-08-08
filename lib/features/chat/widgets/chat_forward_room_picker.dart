import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

/// Forward-target room picker (Issue #132 "Forwarding Gateway" AC).
void showChatForwardRoomPicker(
  BuildContext context, {
  required List<ChatRoomEntity> rooms,
  required String forwarderId,
  required void Function(ChatRoomEntity) onSelect,
}) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: rooms.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No other conversations to forward to.'))
          : ListView(
              shrinkWrap: true,
              children: rooms.map((room) {
                final otherId = room.participantAId == forwarderId
                    ? room.participantBId
                    : room.participantAId;
                return ListTile(
                  title: Text(otherId),
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(room);
                  },
                );
              }).toList(),
            ),
    ),
  );
}
