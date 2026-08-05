import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_campaign_markup.dart';
import 'package:growth_pilot_ai/core/models/rich_text_segment.dart';

void main() {
  test('plain text with no tokens returns a single unstyled segment', () {
    final result = ParseCampaignMarkup.call('Hello merchants');

    expect(result, [const RichTextSegment('Hello merchants')]);
  });

  test('bold and italic tokens are parsed into styled segments in order', () {
    final result = ParseCampaignMarkup.call('Hi **Ahmad**, enjoy _10% off_ today');

    expect(result, [
      const RichTextSegment('Hi '),
      const RichTextSegment('Ahmad', bold: true),
      const RichTextSegment(', enjoy '),
      const RichTextSegment('10% off', italic: true),
      const RichTextSegment(' today'),
    ]);
  });

  test('empty markup returns no segments', () {
    expect(ParseCampaignMarkup.call(''), isEmpty);
  });
}
