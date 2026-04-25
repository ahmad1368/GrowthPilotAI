import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/widgets/glass_card.dart';
// ۱. حتما ویجت جدید را ایمپورت کنید (مسیر را با پروژه خودتان چک کنید)
import 'package:growth_pilot_ai/widgets/neon_icon.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowthPilotAI',
      theme: AppTheme.light(), 
      darkTheme: AppTheme.dark(), 
      themeMode: ThemeMode.system, 
      home: const MyHomePage(title: 'GrowthPilot Dashboard'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_pilot.png',
              fit: BoxFit.cover,
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlassCard(
                  width: 320, // کمی عرض را بیشتر کردیم برای جایگیری بهتر آیکون‌ها
                  opacity: 0.5, 
                  child: Column(
                    children: [
                      // استفاده از NeonIcon با تنظیم دستی (مثال ۲ شما)
                      const NeonIcon(
                        icon: Icons.analytics_outlined,
                        isAnimated: true, // فعال کردن حرکت زنده
                        opacity: 0.9, 
                        color: Colors.cyanAccent,
                        size: 50,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Total3 Performance Boost:',
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_counter%',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // استفاده از NeonIcon با تنظیم هوشمند (مثال ۱ شما)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeonIcon(icon: Icons.rocket_launch,opacity: 0.1, size: 20),                          
                          SizedBox(width: 8),
                          Text('System Optimized', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Update Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}