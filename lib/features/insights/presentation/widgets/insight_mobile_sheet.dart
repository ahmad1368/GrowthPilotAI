import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightMobileSheet {
  static void show(BuildContext context, InsightModel insight) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(insight.title, style: ShadTheme.of(context).textTheme.h3),
              const SizedBox(height: 12),
              Text(insight.description,
                  style: ShadTheme.of(context).textTheme.p),
              const SizedBox(height: 20),
              ShadButton(
                width: double.infinity,
                text: const Text("بستن"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
