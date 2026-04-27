import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'glass_app_bar.dart';
import 'insight_card.dart';
import 'notification_badge.dart';
import 'omni_glass_container.dart';
import '../services/notification_service.dart';
import '../models/notification_model.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;
  double _appBarOpacity = 0.0;

  final List<AppNotification> _notifications = [
    AppNotification(id: "1", title: "AI Core", body: "سیستم بهینه شد.", footer: "System", date: DateTime.now()),
    // ۱۰ مورد دیگر در اینجا قرار می‌گیرد...
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {
      setState(() => _appBarOpacity = (_scrollController.offset / 200).clamp(0.0, 1.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: GlassAppBar(
        title: "GrowthPilot AI",
        opacity: _appBarOpacity,
        actions: [
          NotificationBadge(
            count: unreadCount,
            onTap: () => NotificationService.showMenu(
              context: context,
              notifications: _notifications,
              onDelete: (index) => setState(() => _notifications.removeAt(index)),
              onRead: (item) => setState(() => item.isRead = true),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 40, 20, 100),
      itemCount: 15,
      itemBuilder: (context, index) => InsightCard(
        title: "Insight #$index",
        description: "تحلیل لحظه‌ای سیستم برای بهبود عملکرد دارایی‌های دیجیتال شما.",
        efficiency: "${(index + 1) * 7}% Efficiency",
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: OmniGlassContainer(
        borderRadius: 30,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Insights'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}