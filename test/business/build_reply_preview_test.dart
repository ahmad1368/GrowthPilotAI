import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_reply_preview.dart';

void main() {
  test('returns short bodies unchanged', () {
    expect(BuildReplyPreview.call('hello'), 'hello');
  });

  test('truncates bodies over 50 chars with an ellipsis', () {
    final body = 'a' * 60;
    final preview = BuildReplyPreview.call(body);
    expect(preview.length, BuildReplyPreview.maxLength + 1);
    expect(preview.endsWith('…'), isTrue);
  });

  test('leaves a body exactly at the cap unchanged', () {
    final body = 'a' * BuildReplyPreview.maxLength;
    expect(BuildReplyPreview.call(body), body);
  });
}
