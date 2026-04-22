import 'package:flutter/material.dart';
// حتما این دو فایل را با توجه به مسیر پروژه خودت ایمپورت کن
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/widgets/glass_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowthPilotAI',
      // --- جایگذاری کدی که خواسته بودید ---
      theme: AppTheme.light(), 
      darkTheme: AppTheme.dark(), 
      themeMode: ThemeMode.system, 
      // ----------------------------------
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
      // استفاده از رنگ‌های تم به جای هارد-کد کردن
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent, // طبق داکیومنت Issue #1
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // استفاده از ویجت اختصاصی GlassCard
            GlassCard(
              width: 300,
              child: Column(
                children: [
                  const Text(
                    'Total Performance Boost:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_counter%',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Update Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}