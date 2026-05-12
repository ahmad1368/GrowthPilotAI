import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRSpatialSorter {
  static List<TextBlock> sort(RecognizedText data) {
    List<TextBlock> blocks = List.from(data.blocks);
    const double rowThreshold = 15.0; // تلورانس ۱۵ پیکسلی برای لرزش دست

    blocks.sort((a, b) {
      final rectA = a.boundingBox;
      final rectB = b.boundingBox;

      // اگر دو بلاک در یک ردیف افقی باشند (با در نظر گرفتن تلورانس)
      if ((rectA.top - rectB.top).abs() < rowThreshold) {
        return rectA.left.compareTo(rectB.left); // مرتب‌سازی چپ به راست
      }
      return rectA.top.compareTo(rectB.top); // مرتب‌سازی بالا به پایین
    });

    return blocks;
  }
}
