import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../models/ocr_block_data.dart';

/// Maps ML Kit's [TextBlock]s to the portable [OCRBlockData] the scanning
/// overlay (Issue #26) renders — keeps ML Kit's types confined to the OCR
/// service layer instead of leaking into scanner_workflow.dart / the UI.
class OcrBlockMapper {
  static List<OCRBlockData> map(List<TextBlock> blocks) {
    return blocks
        .map((b) => OCRBlockData(boundingBox: b.boundingBox, text: b.text))
        .toList();
  }
}
