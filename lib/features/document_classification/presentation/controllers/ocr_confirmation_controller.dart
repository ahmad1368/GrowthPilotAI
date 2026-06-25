import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';

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

      OmniLogger.info(
        title: "ثبت تراکنش OCR",
        message: "فروشنده: ${vendorController.text} | مبلغ: $parsedAmount",
        widgetName: "OcrConfirmationController",
      );

      // در اینجا متد ذخیره ریپازیتوری شما صدا زده می‌شود.
      // با توجه به Mock بودن ریپازیتوری در این مرحله، عملیات با موفقیت تظاهر می‌شود.
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
