import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/transaction_controller.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart'; // اضافه شد
import '../widgets/adaptive_text.dart'; // اضافه شد
import '../models/insight_model.dart';
import '../widgets/omni_glass_panel.dart';
import 'package:get/get.dart';

class InsightPage extends StatefulWidget {
  final ScrollController controller;

  const InsightPage({super.key, required this.controller});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final TransactionController transactionController =
      Get.find<TransactionController>();

  final List<InsightModel> dummyInsights = List.generate(
    15,
    (index) => InsightModel(
      id: index,
      title: "تحلیل هوشمند شماره $index",
      description:
          "این یک توضیح برای تحلیل شماره $index است. اگر متن طولانی شود، ارتفاع کارت به صورت خودکار افزایش می‌یابد تا تمام جزئیات نمایش داده شود.",
      efficiency: "${(index + 1) * 5}%",
    ),
  );

  int? selectedIndex;

  void _handleOnTap(int index) {
    final selectedData = dummyInsights[index];
    if (UIHelper.isWide(context)) {
      setState(() {
        selectedIndex = index;
      });
    } else {
      _showMobileDetails(selectedData);
    }
  }

  void _showMobileDetails(InsightModel data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(128),
      builder: (context) => OmniGlassPanel(
        title: data.title,
        description: data.description,
        showCloseButton: true,
        avoidSystemBars: true,
        // استفاده از آیکون ملموس در شیت موبایل
        leadingIcon: Icons.insights_rounded,
        actionButtons: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const AdaptiveText("متوجه شدم"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool wideMode = UIHelper.isWide(context);

    if (wideMode) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildListView(),
          ),
          const VerticalDivider(width: 1, color: Colors.white10),
          Expanded(
            flex: 3,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedIndex == null
                  ? Center(
                      child: const AdaptiveText(
                        "یک مورد را برای مشاهده جزئیات انتخاب کنید",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : Padding(
                      key: ValueKey(selectedIndex),
                      padding: const EdgeInsets.all(24.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: UIHelper.getAdaptiveWidth(context),
                          // بخش جزئیات در سمت راست (تبلت)
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 100),
                            child: OmniGlassPanel(
                              title: dummyInsights[selectedIndex!].title,
                              description:
                                  dummyInsights[selectedIndex!].description,
                              opacity: 0.05,
                              leadingIcon: Icons
                                  .psychology_alt_rounded, // آیکون هوش مصنوعی
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
                    ),
            ),
          ),
        ],
      );
    } else {
      return _buildListView();
    }
  }

  Widget _buildListView() {
    return CustomScrollView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Obx(() {
              final transactions = transactionController.filteredTransactions;
              final int count = transactions.length;
              final double total =
                  transactions.fold(0, (sum, item) => sum + item.amount);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: UIHelper.isWide(context)
                    ? _buildTabletHeader(count, total)
                    : _buildMobileHeader(count, total),
              );
            }),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildInsightCard(index,
                  defaultHeight: 20.0), // فراخوانی متد جدید
              childCount: dummyInsights.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletHeader(int count, double total) {
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

  Widget _buildMobileHeader(int count, double total) {
    return Column(
      children: [
        _infoCard("مجموع هزینه‌ها", "${total.toStringAsFixed(0)} \$",
            Icons.account_balance_wallet, Colors.greenAccent),
      ],
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withAlpha(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withAlpha(40),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AdaptiveText(title,
                    style:
                        const TextStyle(color: Colors.white60, fontSize: 11)),
                AdaptiveText(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(int index, {double defaultHeight = 20.0}) {
    final isSelected = selectedIndex == index;

    // محاسبه ارتفاع: در مانیتور ارتفاع کل تقسیم بر 3.5 تا حداقل 3 کارت جا شود
    double? maxHeight = UIHelper.isWide(context)
        ? (MediaQuery.of(context).size.height / 3.5)
        : null;

    return GestureDetector(
      onTap: () => _handleOnTap(index),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.transparent,
              width: 2,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 20, // حداقل ارتفاع مورد نظر شما
              maxHeight: maxHeight ?? double.infinity,
            ),
            child: OmniGlassPanel(
              title: dummyInsights[index].title,
              description: dummyInsights[index].description,
              leadingIcon: Icons.auto_graph_rounded,
              height: null, // حتما null باشد تا FlexFit.loose فعال شود
              // سایر پارامترها...
            ),
          ),
        ),
      ),
    );
  }
}
