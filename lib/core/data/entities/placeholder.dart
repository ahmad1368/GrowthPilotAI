import 'package:objectbox/objectbox.dart';
import 'package:flutter/material.dart';

@Entity()
class Placeholder {
  @Id()
  int id = 0;

  String? name;

  // اضافه کردن متادیتای بصری برای ملموس شدن در UI
  @Transient() // این فیلد در دیتابیس ذخیره نمی‌شود و فقط برای UI است
  final IconData displayIcon = Icons.storage_rounded;

  @Transient()
  final Color statusColor = Colors.greenAccent;

  Placeholder({this.id = 0, this.name});
}
