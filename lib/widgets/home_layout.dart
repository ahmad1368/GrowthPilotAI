import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ایمپورت‌های اختصاصی پروژه طبق آدرس‌های شما
import 'package:growth_pilot_ai/widgets/glass_card.dart';
import 'package:growth_pilot_ai/widgets/neon_icon.dart';
import 'package:growth_pilot_ai/widgets/dynamic_app_bar.dart';
import 'package:growth_pilot_ai/widgets/app_drawer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    // گوش دادن به اسکرول برای تغییر ظاهر DynamicAppBar
    _scrollController.addListener(() {
      if (_scrollController.offset != _scrollOffset) {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // جلوگیری از نشت حافظه
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // لیست صفحات برای جابجایی در BottomNavigationBar
    final List<Widget> pages = [
      _buildHomeContent(), // صفحه اول با لیست اسکرول‌شونده
      const Center(child: Text("AI insights Page", style: TextStyle(color: Colors.white))),
      const Center(child: Text("B2B Marketplace", style: TextStyle(color: Colors.white))),
      const Center(child: Text("App Settings", style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      // اجازه دادن به محتوا برای رفتن زیر AppBar و BottomBar
      extendBody: true, 
      extendBodyBehindAppBar: true,
      
      // منوی همبرگری که در فایل app_drawer.dart ساختیم
      drawer: const AppDrawer(),

      // نوار بالای داینامیک که به اسکرول حساس است
      appBar: DynamicAppBar(
        scrollOffset: _scrollOffset,
        title: "GrowthPilot AI",
      ),

      body: Stack(
        children: [
          // ۱. پس‌زمینه ثابت اپلیکیشن
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_pilot.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // ۲. نمایش صفحات با حفظ وضعیت (State)
          IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
        ],
      ),

      // ۳. نوار ناوبری پایین با طراحی شیشه‌ای (Issue #5)
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // محتوای نمونه برای صفحه Home (لیستی که باعث اسکرول و تغییر AppBar می‌شود)
  Widget _buildHomeContent() {
    return ListView.builder(
      controller: _scrollController, // بسیار مهم: وصل کردن کنترلر به لیست
      padding: const EdgeInsets.only(top: 120, bottom: 100),
      itemCount: 15,
      itemBuilder: (context, index) => GlassCard(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        borderRadius: 20,
        child: ListTile(
          leading: const NeonIcon(icon: Icons.auto_graph, size: 30),
          title: Text("Financial Report #$index", 
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text("AI Analysis completed successfully", 
            style: TextStyle(color: Colors.white.withOpacity(0.6))),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        ),
      ),
    );
  }

  // ویجت اختصاصی برای نوار ناوبری پایین جهت تمیز ماندن متد Build
  Widget _buildBottomNav() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: GlassCard(
          borderRadius: 30,
          opacity: 0.1,
          blur: 15,
          padding: EdgeInsets.zero, // حذف پدینگ داخلی برای فیت شدن Nav
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              HapticFeedback.lightImpact(); // لرزش ملایم هنگام کلیک
              setState(() => _currentIndex = index);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.white.withOpacity(0.3),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              _buildNavItem(Icons.home_filled, 'Home', 0),
              _buildNavItem(Icons.insights, 'Insights', 1),
              _buildNavItem(Icons.store_mall_directory, 'B2B', 2),
              _buildNavItem(Icons.person_pin, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  // متد کمکی برای ساخت آیتم‌های نوار ناوبری
  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: NeonIcon(
        icon: icon,
        isAnimated: false, // جلوگیری از تداخل کلیک که قبلاً صحبت کردیم
        opacity: _currentIndex == index ? 1.0 : 0.3,
      ),
      label: label,
    );
  }
}