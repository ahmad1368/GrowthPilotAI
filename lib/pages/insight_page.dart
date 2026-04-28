import 'package:flutter/material.dart';
import '../widgets/insight_card.dart'; // مسیر را چک کنید
import '../widgets/standard_detail_widget.dart'; // ویجت مشترکی که صحبت کردیم
import '../models/insight_model.dart';

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
        backgroundColor:
            Colors.transparent, // شفاف کردن پشت برای دیدن Margin ویجت
        useSafeArea: true, // جلوگیری از رفتن زیر نوار وضعیت (Status Bar)
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // جلوگیری از تداخل با کیبورد
          ),
          child: StandardDetailWidget(insight: selectedData),
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
                    ? const Center(child: Text("یک مورد را انتخاب کنید"))
                    : StandardDetailWidget(
                        insight: dummyInsights[
                            selectedIndex!], // داده از آرایه بر اساس انتخاب
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
        child: InsightCard(
          title: dummyInsights[index].title,
          description: dummyInsights[index].description,
          efficiency: dummyInsights[index].efficiency,
        ),
      ),
    );
  }
}
