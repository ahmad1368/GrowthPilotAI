import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/data/models/classification_response.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/entities/document_type.dart';

/// Covers Issue #25's classification threshold. Regression focus: the
/// original `isDocument` check used `||`, so ANY confidently-classified
/// image — not just paper/document classes — passed as a valid receipt.
/// That directly violated the issue's own acceptance criterion ("correctly
/// rejects non-financial images, e.g. a photo of a computer screen").
void main() {
  group('ClassificationResponse.fromMatrix', () {
    test('accepts a confident prediction inside the document class range', () {
      final matrix = _matrixWithPeak(index: 923, quantizedValue: 200); // 0.78

      final result = ClassificationResponse.fromMatrix(matrix);

      expect(result.detectedType, DocumentType.receipt);
      expect(result.isValid, isTrue);
    });

    test('rejects a confident prediction outside the document class range '
        '(e.g. a computer screen)', () {
      final matrix = _matrixWithPeak(index: 500, quantizedValue: 250); // 0.98

      final result = ClassificationResponse.fromMatrix(matrix);

      expect(result.detectedType, DocumentType.background);
      expect(result.isValid, isFalse);
    });

    test('rejects a document-range class below the 70% confidence threshold', () {
      final matrix = _matrixWithPeak(index: 923, quantizedValue: 100); // 0.39

      final result = ClassificationResponse.fromMatrix(matrix);

      expect(result.isValid, isFalse);
    });
  });
}

List<List<int>> _matrixWithPeak({required int index, required int quantizedValue}) {
  final row = List<int>.filled(1001, 0);
  row[index] = quantizedValue;
  return [row];
}
