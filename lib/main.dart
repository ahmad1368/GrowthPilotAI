import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/widgets/home_layout.dart'; // ایمپورت ویجت جدید

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowthPilotAI',
      theme: AppTheme.dark(), // استفاده از تم دارک مستقیم
      home: const HomeLayout(), // صدا زدن لی‌اوت جدید
      debugShowCheckedModeBanner: false,
    );
  }
}