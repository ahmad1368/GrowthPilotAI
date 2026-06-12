import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'insight_header.dart';
import 'insight_scanner_sheet.dart'; // هدایت منطق انتخاب سورس به فایل مجزا جهت رعایت قانون ۵۰ خط

class InsightViewBody extends StatelessWidget {
  final ScrollController? controller;
  const InsightViewBody({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 600;
    final iconColor =
        isDark ? const Color(0xff09090b) : const Color(0xffffffff);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      body: CustomScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        slivers: const [
          InsightHeader(), // استفاده مستقیم از ویجت ارسالی و بهینه شما
          // لایه لیست سکشن پس از ارسال کد تکمیلی شما در اینجا رجیستر می‌شود
        ],
      ),
      floatingActionButton: ShadButton(
        backgroundColor:
            isDark ? const Color(0xffffffff) : const Color(0xff09090b),
        icon: Icon(Icons.document_scanner_rounded, color: iconColor, size: 20),
        text: isWide
            ? Text("Scan New Receipt", style: ShadTheme.of(context).textTheme.p)
            : null,
        onPressed: () => InsightScannerSheet.show(context),
      ),
    );
  }
}
