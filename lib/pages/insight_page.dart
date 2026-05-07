import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/transaction_controller.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../widgets/adaptive_text.dart';
import '../models/insight_model.dart';
import '../widgets/omni_glass_panel.dart';
import 'package:get/get.dart';

class InsightPage extends StatefulWidget {
  final ScrollController? controller;
  final String? title;
  final IconData? icon;
  final Widget? child;

  const InsightPage({
    super.key,
    this.controller,
    this.title,
    this.icon,
    this.child,
  });

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final TransactionController transactionController =
      Get.find<TransactionController>();

  // داده‌های نمونه برای نمایش در لیست
  final List<InsightModel> dummyInsights = List.generate(
    15,
    (index) => InsightModel(
      id: index,
      title: "تحلیل هوشمند شماره ${index + 1}",
      description:
          "این یک توضیح خودکار برای تحلیل وضعیت مالی شماست. در این بخش جزئیات مربوط به تراکنش‌های اخیر و الگوهای مصرفی نمایش داده می‌شود.",
      efficiency: "${(index + 1) * 5}%",
    ),
  );

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    bool wideMode = UIHelper.isWide(context);

    // اولویت با child سفارشی است
    if (widget.child != null) {
      return widget.child!;
    }

    if (wideMode) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildListView(),
          ),
          VerticalDivider(
            width: 1,
            color: Colors.white.withValues(alpha: 0.05),
          ),
          Expanded(
            flex: 3,
            child: _buildDetailsView(),
          ),
        ],
      );
    } else {
      return _buildListView();
    }
  }

  // نمایش جزئیات در سمت راست (مخصوص تبلت و دسکتاپ)
  Widget _buildDetailsView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selectedIndex == null
          ? Center(
              child: AdaptiveText(
                "یک مورد را برای مشاهده جزئیات انتخاب کنید",
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
            )
          : Padding(
              key: ValueKey(selectedIndex),
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: UIHelper.getAdaptiveWidth(context),
                  child: OmniGlassPanel(
                    title: dummyInsights[selectedIndex!].title,
                    description: dummyInsights[selectedIndex!].description,
                    leadingIcon: widget.icon ?? Icons.psychology_alt_rounded,
                    opacity:
                        0.08, // شفافیت کمتر برای پنل بزرگتر جهت خوانایی بیشتر
                    actionButtons: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.troubleshoot_rounded),
                        label: const AdaptiveText("تحلیل عمیق‌تر"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildListView() {
    return CustomScrollView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نمایش عنوان و آیکون در صورت وجود
                if (widget.title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: Colors.blueAccent, size: 28),
                          const SizedBox(width: 12),
                        ],
                        AdaptiveText(
                          widget.title!,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                Obx(() {
                  final transactions =
                      transactionController.filteredTransactions;
                  final double total =
                      transactions.fold(0, (sum, item) => sum + item.amount);

                  return UIHelper.isWide(context)
                      ? _buildTabletHeader(total)
                      : _buildMobileHeader(total);
                }),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildInsightCard(index),
              childCount: dummyInsights.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletHeader(double total) {
    return Row(
      children: [
        Expanded(
            child: _infoCard("مجموع هزینه", "${total.toStringAsFixed(0)} \$",
                Icons.account_balance_wallet, Colors.greenAccent)),
        const SizedBox(width: 12),
        Expanded(
            child: _infoCard("پیش‌بینی AI", "در حال تحلیل...", Icons.psychology,
                Colors.purpleAccent)),
      ],
    );
  }

  Widget _buildMobileHeader(double total) {
    return _infoCard("مجموع هزینه‌ها", "${total.toStringAsFixed(0)} \$",
        Icons.account_balance_wallet, Colors.greenAccent);
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(title,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11)),
              AdaptiveText(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (UIHelper.isWide(context)) {
          setState(() => selectedIndex = index);
        } else {
          _showMobileDetails(dummyInsights[index]);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                width: 2),
          ),
          child: OmniGlassPanel(
            title: dummyInsights[index].title,
            description: dummyInsights[index].description,
            leadingIcon: Icons.auto_graph_rounded,
            isInteractive: true, // فعال کردن افکت Hover و Scale
            opacity:
                isSelected ? 0.2 : 0.05, // کارت انتخاب شده پررنگ‌تر دیده شود
          ),
        ),
      ),
    );
  }

  void _showMobileDetails(InsightModel data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OmniGlassPanel(
        title: data.title,
        description: data.description,
        showCloseButton: true,
        fullBorderRadius: false, // لبه‌های پایین صاف برای چسبیدن به پایین صفحه
        leadingIcon: widget.icon ?? Icons.insights_rounded,
      ),
    );
  }
}
