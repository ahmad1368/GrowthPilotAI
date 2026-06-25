// lib/core/utils/tensor_converter.dart
import 'package:image/image.dart' as img;

class TensorConverter {
  /// تبدیل تصویر به ماتریس ۴ بعدی [1, 224, 224, 3] با مقادیر خام ۰ تا ۲۵۵ برای مدل کوانتیزه
  static List<List<List<List<int>>>> toUint8FourDimensional(img.Image image) {
    return List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(
          224,
          (x) {
            final pixel = image.getPixel(x, _);
            // حذف تقسیم بر 255.0 و پاس دادن مستقیم مقدار صحیح کانال‌های رنگی
            return [pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt()];
          },
        ),
      ),
    );
  }
}
