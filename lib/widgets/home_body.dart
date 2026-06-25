import 'package:flutter/material.dart';
import '../pages/insight_page.dart'; // ایمپورت فایل جدید

class HomeBody extends StatelessWidget {
  final ScrollController controller;

  const HomeBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // حالا بدنه اصلی فقط فراخوان صفحه اینسایت است
    return InsightPage(controller: controller);
  }
}
