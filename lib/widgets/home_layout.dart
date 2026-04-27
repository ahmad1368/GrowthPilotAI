import 'package:flutter/material.dart';
import 'dart:ui'; // برای افکت Blur
import 'app_drawer.dart';
import 'adaptive_text.dart';
import 'omni_glass_container.dart';
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

  // لیست ۱۱تایی نوتیفیکیشن‌ها برای تست
  final List<AppNotification> _notifications = [
    AppNotification(
      id: "1",
      title: "AI Analysis",
      body: "گزارش هفتگی شما آماده است. شاخص‌ها رشد مثبتی را نشان می‌دهند.",
      footer: "System Engine • Analytics",
      date: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ...List.generate(10, (index) => AppNotification(
      id: (index + 2).toString(),
      title: "Update #${index + 2}",
      body: "سیستم در حال بهینه‌سازی پردازش‌های GrowthPilot AI است.",
      footer: "Internal Core",
      date: DateTime.now().subtract(Duration(days: index + 1)),
    )),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        // تغییر شفافیت نوار بالا در بازه ۲۰۰ پیکسل اسکرول
        _appBarOpacity = (_scrollController.offset / 200).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showNotificationMenu() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Material(
              color: Colors.transparent,
              child: OmniGlassContainer(
                borderRadius: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: AdaptiveText("Notifications", fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final item = _notifications[index];
                          return ListTile(
                            leading: Icon(
                              Icons.circle, 
                              size: 10, 
                              color: item.isRead ? Colors.transparent : Colors.blueAccent
                            ),
                            title: AdaptiveText(item.title, 
                                fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, size: 16, color: Colors.redAccent),
                              onPressed: () {
                                setState(() => _notifications.removeAt(index));
                                setDialogState(() {});
                              },
                            ),
                            onTap: () {
                              setState(() => item.isRead = true);
                              setDialogState(() {});
                              Navigator.pop(context);
                              _showNotificationDetail(item);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showNotificationDetail(AppNotification item) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: OmniGlassContainer(
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline_rounded, size: 48, color: Colors.blueAccent),
                const SizedBox(height: 16),
                AdaptiveText(item.title, fontSize: 20, fontWeight: FontWeight.bold),
                const SizedBox(height: 12),
                AdaptiveText(item.body, textAlign: TextAlign.center),
                const Divider(height: 30, color: Colors.white12),
                AdaptiveText(item.footer, fontSize: 12),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const AdaptiveText("Got it", fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    int unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              elevation: 0,
              // رنگ نوار بالا که با اسکرول تیره می‌شود
              backgroundColor: (isDark ? Colors.black : Colors.white)
                  .withOpacity(_appBarOpacity * 0.7),
              title: const AdaptiveText("GrowthPilot AI", fontWeight: FontWeight.bold),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, size: 28), 
                      onPressed: _showNotificationMenu
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        right: 8, top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Center(
                            child: Text(
                              unreadCount > 9 ? "9+" : "$unreadCount", 
                              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                // بخش تنظیمات اصلاح شده
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 40, 20, 100),
        itemCount: 15,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 180, // تعیین ارتفاع کارت به جای ارسال مستقیم به OmniGlassContainer
            child: OmniGlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdaptiveText("Insight #$index", fontSize: 18, fontWeight: FontWeight.bold),
                      const Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
                    ],
                  ),
                  const Spacer(),
                  const AdaptiveText(
                    "Real-time analysis of your digital assets. All systems are optimized."                    
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.bolt, color: Colors.cyanAccent, size: 16),
                      const SizedBox(width: 5),
                      AdaptiveText("${(index + 1) * 7}% Efficiency", fontSize: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: OmniGlassContainer(
          borderRadius: 30,
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: isDark ? Colors.cyanAccent : Colors.blueAccent,
            unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.4),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Insights'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}