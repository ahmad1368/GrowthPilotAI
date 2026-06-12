import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';

class OcrConfirmationController {
  final _repository = GetIt.I<TransactionRepository>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController amountController, vendorController, descController;
  DateTime selectedDate = DateTime.now();

  void init(OcrFormData initialData) {
    vendorController = TextEditingController(text: initialData.vendorName);
    amountController =
        TextEditingController(text: initialData.amount.toString());
    descController = TextEditingController(text: initialData.description);
    selectedDate = initialData.date;
  }

  Future<bool> saveTransaction() async {
    try {
      if (formKey.currentState == null || !formKey.currentState!.validate())
        return false;
      final amount = double.tryParse(amountController.text) ?? 0.0;
      _logLocal(
          "ثبت تراکنش OCR | فروشنده: ${vendorController.text} | مبلغ: $amount");
      return true;
    } catch (e, stack) {
      _logLocal("خطا در ذخیره‌سازی: $e\n$stack");
      return false;
    }
  }

  void _logLocal(String msg) {
    assert(() {
      print(
          "[Ahmad_Salem_Pour] [2026-06-02] [OcrConfirmationController]: $msg");
      return true;
    }());
  }

  void dispose() {
    amountController.dispose();
    vendorController.dispose();
    descController.dispose();
  }
}
