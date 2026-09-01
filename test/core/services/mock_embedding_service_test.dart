import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/services/mock_embedding_service.dart';

void main() {
  group('MockEmbeddingService', () {
    final service = MockEmbeddingService();

    test('produces a 384-dimension vector', () async {
      final response = await service.embed('ABC Logistics, Surrey');
      expect(response.success, isTrue);
      expect(response.data!.length, MockEmbeddingService.dimensions);
    });

    test('is deterministic for the same text', () async {
      final a = await service.embed('ABC Logistics, Surrey');
      final b = await service.embed('ABC Logistics, Surrey');
      expect(a.data, b.data);
    });

    test('differs for different text', () async {
      final a = await service.embed('ABC Logistics, Surrey');
      final b = await service.embed('XYZ Freight, Burnaby');
      expect(a.data, isNot(b.data));
    });
  });
}
