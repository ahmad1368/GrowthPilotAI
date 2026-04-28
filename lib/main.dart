import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        // سایر تنظیمات تم لایت
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        // سایر تنظیمات تم دارک
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          title: 'GrowthPilot AI',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          // نکته کلیدی: انیمیشن را اینجا و به کمک builderِ مسیرها اعمال می‌کنیم
          builder: (context, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              // این بخش باعث می‌شود وقتی تم عوض شد، محتوای صفحه فعلی (child) انیمیت شود
              child: Container(
                key: ValueKey(theme.brightness),
                child: child,
              ),
            );
          },
          home: const HomeLayout(),
          routes: {
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
