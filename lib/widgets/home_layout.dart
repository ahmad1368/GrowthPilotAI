import 'package:flutter/material.dart';
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

  // ۱. لیست ۱۱تایی نوتیفیکیشن‌ها به صورت مستقیم
  final List<AppNotification> _notifications = [
    AppNotification(
      id: "1",
      title: "AI Analysis",
      body: "گزارش هفتگی شما آماده است. تمام شاخص‌ها رشد ۱۵ درصدی را نشان می‌دهند.",
      footer: "System Engine • Analytics",
      date: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    AppNotification(
      id: "2",
      title: "Security Update",
      body: "ورود جدید در منطقه کوکیتلام شناسایی شد. اگر این شما نیستید، حساب خود را ایمن کنید.",
      footer: "Security Center",
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AppNotification(
      id: "3",
      title: "Marketplace",
      body: "یک مشتری جدید به پروژه شما علاقه‌مند شده است.",
      footer: "Surrey Professional Market",
      date: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    // تولید باقی‌مانده نوتیفیکیشن‌ها تا ۱۱ مورد
    ...List.generate(8, (index) => AppNotification(
      id: (index + 4).toString(),
      title: "Notification #${index + 4}",
      body: "سیستم GrowthPilot AI در حال بهینه‌سازی پردازش‌های پس‌زمینه است.",
      footer: "Internal Core v1.0.8",
      date: DateTime.now().subtract(Duration(days: index + 1)),
    )),
  ];

  // متد نمایش لیست نوتیفیکیشن‌ها (منوی استاندارد)
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
                      child: _notifications.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(40),
                              child: AdaptiveText("No notifications"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _notifications.length,
                              itemBuilder: (context, index) {
                                final item = _notifications[index];
                                return Dismissible(
                                  key: Key(item.id),
                                  background: Container(color: Colors.redAccent.withOpacity(0.1)),
                                  onDismissed: (direction) {
                                    setState(() => _notifications.removeAt(index));
                                    setDialogState(() {});
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: item.isRead ? Colors.transparent : Colors.blueAccent,
                                    ),
                                    title: AdaptiveText(item.title, 
                                        fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold),
                                    subtitle: AdaptiveText("${item.date.hour}:${item.date.minute}", fontSize: 10),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.close, size: 18, color: Colors.redAccent),
                                      onPressed: () {
                                        setState(() => _notifications.removeAt(index));
                                        setDialogState(() {});
                                      },
                                    ),
                                    onTap: () {
                                      setState(() => item.isRead = true);
                                      setDialogState(() {});
                                      _showNotificationDetail(item);
                                    },
                                  ),
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

  // متد نمایش جزئیات نوتیفیکیشن در وسط صفحه
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(color: Colors.white12),
                ),
                AdaptiveText(item.footer, fontSize: 12),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const AdaptiveText("Got it", fontWeight: FontWeight.bold),
                )
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

    // محاسبه تعداد نوتیفیکیشن‌های خوانده نشده برای Badge
    int unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        title: const AdaptiveText("GrowthPilot AI", fontWeight: FontWeight.bold),
        actions: [
          // بخش زنگوله با شمارنده هوشمند (فقط خوانده‌نشده‌ها)
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 28),
                onPressed: _showNotificationMenu,
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? "9+" : "$unreadCount",
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Center(child: AdaptiveText("Page Content: $_selectedIndex")),
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