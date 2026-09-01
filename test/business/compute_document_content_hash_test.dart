import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_document_content_hash.dart';

void main() {
  group('ComputeDocumentContentHash', () {
    test('returns the same hash for identical content', () {
      final a = ComputeDocumentContentHash.call('The system shall log events.');
      final b = ComputeDocumentContentHash.call('The system shall log events.');

      expect(a, b);
    });

    test('returns different hashes for different content', () {
      final a = ComputeDocumentContentHash.call('The system shall log events.');
      final b = ComputeDocumentContentHash.call('The system shall export data.');

      expect(a, isNot(b));
    });
  });
}
