import 'package:flutter/material.dart';
import '../models/insight_model.dart';
import '../widgets/omni_glass_panel.dart';

class InsightPage extends StatefulWidget {
  final ScrollController controller;

  const InsightPage({super.key, required this.controller});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
// لیست داده‌های فرضی که در آینده از API گرفته خواهد شد
  final List<InsightModel> dummyInsights = List.generate(
    15,
    (index) => InsightModel(
      id: index,
      title: "Insight #$index",
      description:
          "This is a dummy description for analysis index $index. In the future, this data will come from your API.",
      efficiency: "${(index + 1) * 5}%",
    ),
  );

  // این متغیر برای نگهداری آیتم انتخاب شده در حالت تبلت است
  int? selectedIndex;

  void _handleOnTap(int index) {
    final selectedData =
        dummyInsights[index]; // انتخاب داده بر اساس ایندکس کلیک شده

    double width = MediaQuery.of(context).size.width;

    if (width > 600) {
      // حالت تبلت: آپدیت ایندکس برای نمایش در سمت راست
      setState(() {
        selectedIndex = index;
      });
    } else {
      // حالت گوشی: باز کردن ویجت استاندارد با داده‌های انتخابی
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        builder: (context) => OmniGlassPanel(
          title: selectedData.title,
          description: selectedData.description,
          showCloseButton: true,
          avoidSystemBars: true,
          actionButtons: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Understand"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // --- ساختار تبلت (کنار هم) ---
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildListView(),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 3,
                child: selectedIndex == null
                    ? const Center(
                        child: Text("Select an insight to view details"))
                    : Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: OmniGlassPanel(
                          title: dummyInsights[selectedIndex!].title,
                          description:
                              dummyInsights[selectedIndex!].description,
                          opacity:
                              0.05, // شفافیت کمتر برای هماهنگی با پس‌زمینه تبلت
                          actionButtons: [
                            TextButton(
                              onPressed: () {},
                              child: const Text("Analyze Further"),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        } else {
          // --- ساختار موبایل (فقط لیست) ---
          return _buildListView();
        }
      },
    );
  }

  // متد کمکی برای جلوگیری از تکرار کد لیست
  Widget _buildListView() {
    return ListView.builder(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      itemCount: 15,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => _handleOnTap(index),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OmniGlassPanel(
            title: dummyInsights[index].title,
            description: dummyInsights[index].description,
            height: 120, // ارتفاع ثابت برای کارت‌های لیست
            opacity: 0.1,
          ),
        ),
      ),
    );
  }
}
