import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

class OcrConfirmationController {
  final _repository = GetIt.I<TransactionRepository>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController amountController;
  late TextEditingController vendorController;
  late TextEditingController descController;

  DateTime selectedDate = DateTime.now();

  void init(OcrFormData initialData) {
    vendorController = TextEditingController(text: initialData.vendorName);
    amountController =
        TextEditingController(text: initialData.amount.toString());
    descController = TextEditingController(text: initialData.description);
    selectedDate = initialData.date;
  }

  /// متد ذخیره‌سازی تراکنش ویرایش‌شده پس از اعتبارسنجی موفق فرم
  Future<bool> saveTransaction() async {
    try {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        return false;
      }

      final parsedAmount = double.tryParse(amountController.text) ?? 0.0;

      // [Issue #27] ثبت واقعی در ObjectBox — قبلاً ریپازیتوری Mock بود و این
      // متد فقط تظاهر به موفقیت می‌کرد بدون ذخیره‌سازی واقعی.
      _repository.insert(TransactionEntity(
        amount: parsedAmount,
        date: selectedDate,
        description: descController.text.isNotEmpty
            ? descController.text
            : vendorController.text,
      ));

      OmniLogger.info(
          "ثبت تراکنش OCR (OcrConfirmationController): فروشنده: ${vendorController.text} | مبلغ: $parsedAmount");

      return true;
    } catch (e, stack) {
      OmniLogger.error(
        title: "خطا در ذخیره‌سازی تراکنش",
        message: e,
        stackTrace: stack,
        widgetName: "OcrConfirmationController",
      );
      return false;
    }
  }

  void dispose() {
    amountController.dispose();
    vendorController.dispose();
    descController.dispose();
  }
}
