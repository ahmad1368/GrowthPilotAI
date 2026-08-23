import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/input_sanitizer.dart';

void main() {
  group('InputSanitizer', () {
    test('strips script tags from a chat message body (Issue #167)', () {
      expect(InputSanitizer.clean('<script>alert(1)</script>hello'), 'alert(1)hello');
    });

    test('strips a plain anchor tag but keeps the link text', () {
      expect(InputSanitizer.clean('click <a href="evil.com">here</a>'), 'click here');
    });

    test('trims surrounding whitespace', () {
      expect(InputSanitizer.clean('  hello  '), 'hello');
    });

    test('leaves plain text untouched', () {
      expect(InputSanitizer.clean('hello world'), 'hello world');
    });

    test('escapeHtml escapes HTML-significant characters', () {
      expect(InputSanitizer.escapeHtml('<b>"a" & b</b>'),
          '&lt;b&gt;&quot;a&quot; &amp; b&lt;/b&gt;');
    });
  });
}
