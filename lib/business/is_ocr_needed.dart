/// "Text-Check" decision (Issue #226/#227): if a page's extracted text
/// is under the threshold, treat the source as a scanned image and
/// route it to OCR instead. This is the gate a future #225 pipeline
/// would call before falling back to [DocumentScannerService]/
/// [OCRService] — #225 doesn't extract real PDF/DOCX text yet (no
/// PyMuPDF/python-docx backend exists), so nothing calls this yet (see
/// PR notes).
class IsOcrNeeded {
  static const defaultThreshold = 100;

  static bool call(int extractedCharacterCount, {int threshold = defaultThreshold}) =>
      extractedCharacterCount < threshold;
}
