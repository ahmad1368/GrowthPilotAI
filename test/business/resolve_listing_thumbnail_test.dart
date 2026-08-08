import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_listing_thumbnail.dart';

void main() {
  test('returns the first linked thumbnail', () {
    final bytes = Uint8List.fromList([1, 2, 3]);
    final result = ResolveListingThumbnail.call('5,9', {5: bytes});
    expect(result, bytes);
  });

  test('returns null when the listing has no linked images', () {
    expect(ResolveListingThumbnail.call('', {5: Uint8List(0)}), isNull);
  });

  test('returns null when the linked id has no matching thumbnail', () {
    expect(ResolveListingThumbnail.call('99', {5: Uint8List(0)}), isNull);
  });
}
