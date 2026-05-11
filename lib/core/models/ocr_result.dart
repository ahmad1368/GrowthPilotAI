import 'dart:ui';

class OCRResult {
  final String fullText;
  final List<TextElementModel> elements;

  OCRResult({required this.fullText, required this.elements});
}

class TextElementModel {
  final String text;
  final Rect boundingBox; // مختصات دقیق کلمه در تصویر

  TextElementModel({required this.text, required this.boundingBox});
}
