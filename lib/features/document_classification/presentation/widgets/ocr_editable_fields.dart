import 'package:flutter/material.dart';
import '../controllers/ocr_confirmation_controller.dart';
import '../utils/ocr_amount_validator.dart';
import 'ocr_date_field.dart';
import 'ocr_receipt_image_header.dart';

class OcrEditableFields extends StatelessWidget {
  final OcrConfirmationController controller;

  const OcrEditableFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final receiptImage = controller.receiptImage;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // [Issue #27] Image Header AC — was captured but never displayed.
          if (receiptImage != null) ...[
            OcrReceiptImageHeader(image: receiptImage),
            const SizedBox(height: 16),
          ],
          _buildLabel(context, "نام فروشنده / نوع سند:"),
          TextFormField(
            controller: controller.vendorController,
            style: theme.textTheme.bodyLarge,
            decoration: _getInputDecoration(context, Icons.store_rounded),
          ),
          const SizedBox(height: 16),
          _buildLabel(context, "مبلغ استخراج شده:"),
          TextFormField(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            decoration:
                _getInputDecoration(context, Icons.attach_money_rounded),
            // [Issue #27] Save used to accept any input, silently
            // defaulting an invalid amount to 0.0 instead of blocking it.
            validator: OcrAmountValidator.validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16),
          _buildLabel(context, "تاریخ:"),
          OcrDateField(dateNotifier: controller.dateNotifier),
          const SizedBox(height: 16),
          _buildLabel(context, "متن کامل استخراج شده (OCR Text):"),
          TextFormField(
            controller: controller.descController,
            maxLines: 8,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontFamily: 'monospace', height: 1.4),
            decoration: _getInputDecoration(context, Icons.text_snippet_rounded)
                .copyWith(
              fillColor: isDark ? Colors.black26 : Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, right: 4),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  InputDecoration _getInputDecoration(BuildContext context, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      prefixIcon:
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
      filled: true,
      fillColor: isDark ? Colors.white10 : Colors.white70,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, width: 1.5),
      ),
    );
  }
}
