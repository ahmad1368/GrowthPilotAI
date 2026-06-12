import 'dart:io'; // 💡 اضافه کردن امپورت دارت آی‌او جهت دسترسی به کلاس File
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/features/document_classification/controllers/ocr_confirmation_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';

@GenerateMocks([TransactionRepository])
void main() {
  setUpAll(() {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<TransactionRepository>()) {
      // 💡 توجه: پس از اجرای build_runner، کامپایلر MockTransactionRepository را خواهد شناخت
      // getIt.registerSingleton<TransactionRepository>(MockTransactionRepository());
    }
  });

  test('OcrConfirmationController initializes form fields accurately', () {
    final controller = OcrConfirmationController();
    final mockData = OcrFormData(
      vendorName: 'شرکت تست',
      amount: 1500.0,
      description: 'خرید داکس',
      date: DateTime(2026, 06, 02),
      receiptImage: File(
          'assets/mocks/receipt_test.png'), // 💡 تبدیل موفق رشته به شیء File
    );

    controller.init(mockData);

    expect(controller.vendorController.text, 'شرکت تست');
    expect(controller.amountController.text, '1500.0');
    expect(controller.descController.text, 'خرید داکس');

    controller.dispose();
  });
}
