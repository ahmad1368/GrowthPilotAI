import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/purge_stale_draft_images.dart';

void main() {
  final now = DateTime(2026, 8, 7, 12, 0, 0);

  test('flags unreferenced images older than 24h as stale', () {
    final images = [
      (id: 1, createdAt: now.subtract(const Duration(hours: 25))),
      (id: 2, createdAt: now.subtract(const Duration(hours: 1))),
    ];
    final stale = PurgeStaleDraftImages.call(images: images, referencedIds: {}, now: now);
    expect(stale, [1]);
  });

  test('never flags a referenced image, even if old', () {
    final images = [(id: 1, createdAt: now.subtract(const Duration(hours: 48)))];
    final stale = PurgeStaleDraftImages.call(images: images, referencedIds: {1}, now: now);
    expect(stale, isEmpty);
  });

  test('does not flag an image exactly at the 24h boundary', () {
    final images = [(id: 1, createdAt: now.subtract(const Duration(hours: 24)))];
    final stale = PurgeStaleDraftImages.call(images: images, referencedIds: {}, now: now);
    expect(stale, isEmpty);
  });
}
