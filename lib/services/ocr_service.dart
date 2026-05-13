class OCRResult {
  final String fullText;
  final List<dynamic> elements; // حفظ فیلد قبلی
  final double? confidence; // فیلد جدید برای دقت

  OCRResult({
    required this.fullText,
    required this.elements,
    this.confidence,
  });

  /// متد برای استخراج متن بر اساس منطق خاص یا فیلتر کردن المنت‌ها
  String extractText() {
    if (elements.isEmpty) return fullText;

    // نمونه‌ای از پیاده‌سازی متداول: چسباندن متن المنت‌ها به هم
    // می‌توانید بر اساس نیاز خودتان این بخش را تغییر دهید
    return elements.map((e) => e.toString()).join(' ');
  }

  /// متد برای آزادسازی منابع و پاک‌سازی لیست المنت‌ها
  void dispose() {
    // اگر المنت‌ها اشیایی هستند که نیاز به dispose دارند (مثل کنترلرها)
    // می‌توانید اینجا آن‌ها را مدیریت کنید.
    elements.clear();
    print("OCRResult resources disposed.");
  }

  // متد Factory برای ساخت شیء از JSON (اختیاری اما کاربردی)
  factory OCRResult.fromJson(Map<String, dynamic> json) {
    return OCRResult(
      fullText: json['fullText'] ?? '',
      elements: json['elements'] ?? [],
      confidence: (json['confidence'] as num?)?.toDouble(),
    );
  }

  // متد copyWith برای کپی کردن شیء با مقادیر جدید
  OCRResult copyWith({
    String? fullText,
    List<dynamic>? elements,
    double? confidence,
  }) {
    return OCRResult(
      fullText: fullText ?? this.fullText,
      elements: elements ?? this.elements,
      confidence: confidence ?? this.confidence,
    );
  }
}
