import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_chat_attachment_message.dart';

void main() {
  final now = DateTime(2026, 1, 1);
  final bytes = Uint8List.fromList([1, 2, 3]);

  test('builds an attachment message for an allowed MIME type', () {
    final message = BuildChatAttachmentMessage.call(
        roomId: 1, senderId: 'buyer', fileName: 'spec.png', mimeType: 'image/png', bytes: bytes, now: now);

    expect(message, isNotNull);
    expect(message!.attachmentFileSize, bytes.length);
    expect(message.hasAttachment, isTrue);
  });

  test('rejects a disallowed MIME type', () {
    final message = BuildChatAttachmentMessage.call(
        roomId: 1, senderId: 'buyer', fileName: 'virus.exe',
        mimeType: 'application/x-msdownload', bytes: bytes, now: now);

    expect(message, isNull);
  });

  test('sanitizes a script tag out of the file name (Issue #167)', () {
    final message = BuildChatAttachmentMessage.call(
        roomId: 1, senderId: 'buyer', fileName: '<script>alert(1)</script>spec.png',
        mimeType: 'image/png', bytes: bytes, now: now);

    expect(message!.attachmentFileName, 'alert(1)spec.png');
    expect(message.body, 'alert(1)spec.png');
  });
}
