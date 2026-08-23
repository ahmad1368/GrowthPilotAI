import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_sticker_message.dart';

void main() {
  group('IsStickerMessage', () {
    test('recognizes a catalog sticker glyph (Issue #317 feature #23)', () {
      expect(IsStickerMessage.call('🤝'), isTrue);
      expect(IsStickerMessage.call('👍'), isTrue);
    });

    test('rejects ordinary text', () {
      expect(IsStickerMessage.call('sounds good, let\'s close the deal'), isFalse);
    });

    test('rejects an emoji outside the catalog', () {
      expect(IsStickerMessage.call('🍕'), isFalse);
    });

    test('rejects a catalog emoji embedded in other text', () {
      expect(IsStickerMessage.call('🤝 deal!'), isFalse);
    });
  });
}
