import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../core/theme/app_design_tokens.dart';
import '../utils/ui_helper.dart';
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
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        Expanded(flex: 2, child: _buildListView()),
        VerticalDivider(width: 1, color: onSurface.withValues(alpha: 0.08)),
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
        Text(widget.title ?? "",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 22, fontWeight: FontWeight.bold)),
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
          ? Center(
              child: Text("یک مورد را انتخاب کنید",
                  style: Theme.of(context).textTheme.bodyMedium))
          : _detailsPanel(),
    );
  }

  Widget _detailsPanel() {
    final insight = dummyInsights[selectedIndex!];
    return Padding(
      key: ValueKey(selectedIndex),
      padding: const EdgeInsets.all(24.0),
      child: _insightCard(
        title: insight.title,
        description: insight.description,
        icon: widget.icon ?? Icons.psychology_alt_rounded,
        actionButtons: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.troubleshoot_rounded),
              label: const Text("تحلیل عمیق‌تر")),
        ],
      ),
    );
  }

  void _showMobileDetails(InsightModel data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _insightCard(
        title: data.title,
        description: data.description,
        icon: widget.icon ?? Icons.insights_rounded,
        topRoundedOnly: true,
      ),
    );
  }

  /// Flat replacement for the former OmniGlassPanel title/description/
  /// actions card (matches NotificationSheet/InsightListItem's pattern).
  Widget _insightCard({
    required String title,
    required String description,
    required IconData icon,
    List<Widget>? actionButtons,
    bool topRoundedOnly = false,
  }) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppDesignTokens.card(theme.brightness),
        borderRadius: topRoundedOnly
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : BorderRadius.circular(AppDesignTokens.radiusLg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: onSurface.withValues(alpha: 0.9), size: 24),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(title,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800))),
            ],
          ),
          const SizedBox(height: 12),
          Text(description,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: onSurface.withValues(alpha: 0.7))),
          if (actionButtons != null) ...[
            const SizedBox(height: 20),
            Divider(color: onSurface.withValues(alpha: 0.08), height: 1),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(spacing: 12, children: actionButtons),
            ),
          ],
        ],
      ),
    );
  }
}