import 'dart:io';

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

  /// [Issue #27] Editable via the confirmation screen's date picker — a
  /// ValueNotifier (rather than a plain field) so the picker's selection
  /// actually reaches the UI without a full form rebuild.
  late ValueNotifier<DateTime> dateNotifier;

  /// [Issue #27] The cropped receipt image; was captured by ScannerWorkflow
  /// but previously dropped before reaching this screen even though the
  /// issue's own AC requires displaying it as a header.
  File? receiptImage;

  /// Detected receipt currency (Issue #24) — not yet persisted on
  /// [TransactionEntity], which has no currency field; kept here so it's
  /// available to the confirmation screen and future save logic.
  String currency = 'CAD';

  void init(OcrFormData initialData) {
    vendorController = TextEditingController(text: initialData.vendorName);
    amountController =
        TextEditingController(text: initialData.amount.toString());
    descController = TextEditingController(text: initialData.description);
    dateNotifier = ValueNotifier(initialData.date);
    receiptImage = initialData.receiptImage;
    currency = initialData.currency;
  }

  /// متد ذخیره‌سازی تراکنش ویرایش‌شده پس از اعتبارسنجی موفق فرم
  Future<bool> saveTransaction() async {
    try {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        return false;
      }

      final parsedAmount = double.parse(amountController.text);

      // [Issue #27] ثبت واقعی در ObjectBox — قبلاً ریپازیتوری Mock بود و این
      // متد فقط تظاهر به موفقیت می‌کرد بدون ذخیره‌سازی واقعی.
      _repository.insert(TransactionEntity(
        amount: parsedAmount,
        date: dateNotifier.value,
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
    dateNotifier.dispose();
  }
}
