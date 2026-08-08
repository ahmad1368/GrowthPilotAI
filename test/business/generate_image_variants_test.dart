import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:growth_pilot_ai/business/generate_demo_source_image.dart';
import 'package:growth_pilot_ai/business/generate_image_variants.dart';

void main() {
  test('produces a 200x200 thumbnail and caps the standard variant at 800px', () {
    final source = GenerateDemoSourceImage.call(size: 1000);
    final variants = GenerateImageVariants.call(source);
    final thumb = img.decodeJpg(variants.thumbnail)!;
    final standard = img.decodeJpg(variants.standard)!;
    expect(thumb.width, 200);
    expect(thumb.height, 200);
    expect(standard.width, lessThanOrEqualTo(800));
  });

  test('does not upscale an already-small image', () {
    final source = GenerateDemoSourceImage.call(size: 300);
    final variants = GenerateImageVariants.call(source);
    final standard = img.decodeJpg(variants.standard)!;
    expect(standard.width, 300);
  });

  test('reports the original byte size', () {
    final source = GenerateDemoSourceImage.call(size: 300);
    final variants = GenerateImageVariants.call(source);
    expect(variants.originalSizeBytes, source.length);
  });
}
