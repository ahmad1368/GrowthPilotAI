import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_auto_support_reply.dart';

void main() {
  group('BuildAutoSupportReply', () {
    test('recognizes bank/Plaid/MFA friction points (Issue #193 user story)', () {
      expect(BuildAutoSupportReply.call('My bank MFA code failed'), contains('bank-connection'));
      expect(BuildAutoSupportReply.call('Plaid link is stuck'), contains('bank-connection'));
    });

    test('recognizes OCR/scanning friction points', () {
      expect(BuildAutoSupportReply.call('The receipt scan is blurry'), contains('scanning'));
    });

    test('recognizes marketplace matching friction points', () {
      expect(BuildAutoSupportReply.call('No marketplace matches found'), contains('Marketplace matching'));
    });

    test('falls back to a generic acknowledgment for anything else', () {
      expect(BuildAutoSupportReply.call('Just saying hi'), contains("We've received your message"));
    });
  });
}
