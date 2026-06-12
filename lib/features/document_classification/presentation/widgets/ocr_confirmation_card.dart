import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/features/document_classification/controllers/ocr_confirmation_controller.dart';
import 'ocr_editable_fields.dart';

class OcrConfirmationCard extends StatefulWidget {
  final OcrFormData initialData;
  const OcrConfirmationCard({super.key, required this.initialData});

  @override
  State<OcrConfirmationCard> createState() => _OcrConfirmationCardState();
}

class _OcrConfirmationCardState extends State<OcrConfirmationCard> {
  final _controller = OcrConfirmationController();

  @override
  void initState() {
    super.initState();
    _controller.init(widget.initialData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Form(
      key: _controller.formKey,
      child: ShadCard(
        backgroundColor:
            isDark ? const Color(0xff18181b) : const Color(0xffffffff),
        padding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Icon(Icons.rate_review_rounded, color: fgColor, size: 20),
            const SizedBox(width: 8),
            Text("تایید و ویرایش فاکتور فیسکال",
                style: ShadTheme.of(context).textTheme.h4),
          ],
        ),
        content: OcrEditableFields(controller: _controller),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              text: const Text("انصراف"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            ShadButton(
              backgroundColor: const Color(0xff2563eb),
              text: const Text("تایید فاکتور"),
              onPressed: () {
                if (_controller.formKey.currentState?.validate() ?? false) {
                  // منتظر تزریق نهایی متد کنترلر
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
