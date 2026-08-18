import 'package:growth_pilot_ai/business/normalize_whitespace.dart';
import 'package:growth_pilot_ai/business/strip_control_characters.dart';
import 'package:growth_pilot_ai/business/strip_legal_boilerplate_lines.dart';
import 'package:growth_pilot_ai/business/strip_page_number_artifacts.dart';
import 'package:growth_pilot_ai/business/strip_table_of_contents_lines.dart';
import 'package:growth_pilot_ai/core/models/sanitized_text_result.dart';

/// The "Smart Text Sanitization Engine" pipeline (Issue #227) — a
/// regex/keyword-based local pipeline, not the issue's PyMuPDF
/// coordinate-based (bbox) header/footer detection: this app never
/// receives page geometry, only plain OCR/extracted text (see PR
/// notes). [stripBoilerplate] is the AC's "Advanced Cleaning" toggle —
/// legal footers and Table of Contents lines are the two artifact
/// classes this local pipeline can actually detect (no table/image
/// structure exists in plain text to selectively include/exclude).
class SanitizeDocumentText {
  static SanitizedTextResult call(String rawText, {bool stripBoilerplate = true}) {
    var text = StripControlCharacters.call(rawText);
    text = StripPageNumberArtifacts.call(text);
    if (stripBoilerplate) {
      text = StripLegalBoilerplateLines.call(text);
      text = StripTableOfContentsLines.call(text);
    }
    text = NormalizeWhitespace.call(text);

    return SanitizedTextResult(rawText: rawText, sanitizedText: text);
  }
}
