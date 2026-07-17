import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sanitize_push_preview.dart';

void main() {
  test('masks a body containing a dollar amount', () {
    final result = SanitizePushPreview.call('Large charge of \$54,200.00 detected');
    expect(result.contains('\$'), isFalse);
    expect(result, 'A transaction update is available. Open the app for details.');
  });

  test('leaves a body with no amount untouched', () {
    const body = 'Your vendor sent a new message.';
    expect(SanitizePushPreview.call(body), body);
  });
}
