import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrConfidenceCalculator {
  static double calculate(RecognizedText recognizedText) {
    if (recognizedText.blocks.isEmpty) return 0.0;

    double totalConfidence = 0.0;
    int elementCount = 0;

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          totalConfidence += (element.confidence ?? 1.0);
          elementCount++;
        }
      }
    }
    return elementCount > 0 ? (totalConfidence / elementCount) : 1.0;
  }
}
