import 'package:objectbox/objectbox.dart';

@Entity()
class DocumentType {
  @Id()
  int id = 0;

  @Index()
  final String name; // نام سند: رسید، قرارداد، فاکتور تعمیرات

  final bool isPublic; // آیا این نوع سند توسط سیستم تعریف شده؟

  final String iconName; // نام آیکون مرتبط برای نمایش در UI

  DocumentType({
    required this.name,
    this.isPublic = false,
    this.iconName = 'description_outlined',
  });
}
