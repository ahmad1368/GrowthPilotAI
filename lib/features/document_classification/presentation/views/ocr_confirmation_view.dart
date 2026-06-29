import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';
import '../controllers/ocr_confirmation_controller.dart';
import '../widgets/ocr_editable_fields.dart';
import '../widgets/ocr_action_buttons.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _controller.formKey,
            child: OmniGlassPanel(
              title: "تایید و ویرایش فاکتور فیسکال",
              leadingIcon: Icons.rate_review_rounded,
              opacity: isDark ? 0.15 : 0.85,
              actionButtons: [OcrActionButtons(controller: _controller)],
              child: OcrEditableFields(controller: _controller),
            ),
          ),
        ),
      ),
    );
  }
}