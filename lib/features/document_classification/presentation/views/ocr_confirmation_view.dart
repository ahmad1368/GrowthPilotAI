import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import '../controllers/ocr_confirmation_controller.dart';
import '../widgets/ocr_editable_fields.dart';
import '../widgets/ocr_action_buttons.dart';

/// Flat OCR confirmation screen — replaces the former OmniGlassPanel wrapper
/// with the app's standard ShadCard (title/child), matching the convention
/// already used throughout lib/features/settings and lib/features/transactions.
class OcrConfirmationView extends StatefulWidget {
  final OcrFormData initialData;
  const OcrConfirmationView({super.key, required this.initialData});

  @override
  State<OcrConfirmationView> createState() => _OcrConfirmationViewState();
}

class _OcrConfirmationViewState extends State<OcrConfirmationView> {
  final _controller = OcrConfirmationController();

  @override
  void initState() {
    super.initState();
    _controller.init(widget.initialData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); // اصلاح خطای تایپی لایف‌سایکل سوپر کلاس
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _controller.formKey,
            child: ShadCard(
              title: Row(
                children: [
                  Icon(Icons.rate_review_rounded,
                      color: Theme.of(context).colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(child: Text("تایید و ویرایش فاکتور فیسکال")),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OcrEditableFields(controller: _controller),
                  const SizedBox(height: 16),
                  OcrActionButtons(controller: _controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
