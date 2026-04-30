import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/main.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // چون MyApp حالا به پارامتر نیاز دارد یا ساختار متفاوتی دارد
    // برای تست اولیه فقط لود شدن برنامه را چک می‌کنیم
    await tester
        .pumpWidget(const MyApp(savedThemeMode: AdaptiveThemeMode.light));

    // بررسی اینکه آیا برنامه بدون کرش کردن بالا می‌آید
    expect(find.byType(MyApp), findsOneWidget);
  });
}
