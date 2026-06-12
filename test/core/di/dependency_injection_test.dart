import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';

void main() {
  setUp(() async {
    // 💡 پاک‌سازی کانتینر GetIt قبل از هر تست برای جلوگیری از تداخل وابستگی‌های ثبت‌شده
    await GetIt.instance.reset();
  });

  test('Dependency Injection should register services successfully', () async {
    // 💡 استفاده از returnsNormally جهت اطمینان از اجرای بدون خطای متد مقداردهی اولیه DI
    expect(
      () => DependencyInjection.init(),
      returnsNormally,
    );
  });
}
