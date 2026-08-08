import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:growth_pilot_ai/business/generate_demo_source_image.dart';

void main() {
  test('generates a decodable square PNG of the requested size', () {
    final bytes = GenerateDemoSourceImage.call(size: 64);
    final decoded = img.decodePng(bytes)!;
    expect(decoded.width, 64);
    expect(decoded.height, 64);
  });
}
