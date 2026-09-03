import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../utils/ui_helper.dart';
import '../widgets/adaptive_text.dart';
import '../widgets/omni_glass_panel.dart';
import '../widgets/insight/insight_list_item.dart';
import '../models/insight_model.dart';

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
  final controller = Get.find<TransactionController>();
  int? selectedIndex;

  final List<InsightModel> dummyInsights = List.generate(
    15,
    (i) => InsightModel(
        id: i,
        title: "تحلیل جدید هوشمند شماره ${i + 1}",
        description: "الگوهای مصرفی و جزئیات تراکنش‌های اخیر.",
        efficiency: "85%"),
  );

  @override
  Widget build(BuildContext context) {
    final bool isWide = UIHelper.isWide(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: widget.child ?? (isWide ? _buildWideLayout() : _buildListView()),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildListView()),
        VerticalDivider(width: 1, color: Colors.white.withValues(alpha: 0.05)),
        Expanded(flex: 3, child: _buildDetailsView()),
      ],
    );
  }

  Widget _buildListView() {
    return CustomScrollView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildSliverHeader(),
        _buildSliverList(),
      ],
    );
  }

  Widget _buildSliverHeader() {
    // Issue #9 AC: HomeLayout's Scaffold uses extendBodyBehindAppBar, so
    // this scrolling content starts under the status bar + app bar unless
    // it adds that safe-area inset itself.
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, topInset + 20, 20, 0),
        child: _buildTitleRow(),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        if (widget.icon != null)
          Icon(widget.icon, color: Colors.blueAccent, size: 28),
        const SizedBox(width: 12),
        AdaptiveText(widget.title ?? "",
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildSliverList() {
    // Issue #9 AC: extendBody means the floating HomeBottomNav can overlap
    // the last list item unless this accounts for the actual safe-area
    // inset (not just a fixed guess) on top of the nav's own footprint.
    final bottomInset = MediaQuery.of(context).padding.bottom + 80;
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => InsightListItem(
            data: dummyInsights[index],
            isSelected: selectedIndex == index,
            onTap: () => _handleItemTap(index),
          ),
          childCount: dummyInsights.length,
        ),
      ),
    );
  }

  void _handleItemTap(int index) {
    if (UIHelper.isWide(context)) {
      setState(() => selectedIndex = index);
    } else {
      _showMobileDetails(dummyInsights[index]);
    }
  }

  Widget _buildDetailsView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selectedIndex == null
          ? const Center(child: AdaptiveText("یک مورد را انتخاب کنید"))
          : _detailsPanel(),
    );
  }

  Widget _detailsPanel() {
    return Padding(
      key: ValueKey(selectedIndex),
      padding: const EdgeInsets.all(24.0),
      child: OmniGlassPanel(
        title: dummyInsights[selectedIndex!].title,
        description: dummyInsights[selectedIndex!].description,
        leadingIcon: widget.icon ?? Icons.psychology_alt_rounded,
        actionButtons: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.troubleshoot_rounded),
              label: const AdaptiveText("تحلیل عمیق‌تر")),
        ],
      ),
    );
  }

  void _showMobileDetails(InsightModel data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => OmniGlassPanel(
        title: data.title,
        description: data.description,
        showCloseButton: true,
        fullBorderRadius: false,
        leadingIcon: widget.icon ?? Icons.insights_rounded,
      ),
    );
  }
}