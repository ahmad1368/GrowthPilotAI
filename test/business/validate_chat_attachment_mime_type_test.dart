import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_chat_attachment_mime_type.dart';

void main() {
  test('allows professional formats', () {
    expect(ValidateChatAttachmentMimeType.call('application/pdf'), isTrue);
    expect(ValidateChatAttachmentMimeType.call('image/png'), isTrue);
    expect(ValidateChatAttachmentMimeType.call('image/jpeg'), isTrue);
  });

  test('blocks executable scripts and unknown types', () {
    expect(ValidateChatAttachmentMimeType.call('application/x-msdownload'), isFalse);
    expect(ValidateChatAttachmentMimeType.call('text/x-sh'), isFalse);
  });
}
