import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/ocr_confirmation_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';

class OcrConfirmationView extends StatefulWidget {
  final OcrFormData initialData;
  const OcrConfirmationView({super.key, required this.initialData});

  @override
  State<OcrConfirmationView> createState() => _OcrConfirmationViewState();
}

class _OcrConfirmationViewState extends State<OcrConfirmationView> {
  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: OcrConfirmationCard(initialData: widget.initialData),
        ),
      ),
    );
  }
}
