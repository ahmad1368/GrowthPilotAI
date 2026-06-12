import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DbStatusActions extends StatelessWidget {
  final bool isWide;

  const DbStatusActions({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton.ghost(
            onPressed: () {},
            text: const Text("View Schema"), // تغییر نام child به text
          ),
          const SizedBox(width: 8),
          ShadButton(
            backgroundColor: const Color(0xff2563eb),
            onPressed: () {},
            text: const Text("Sync Store"), // تغییر نام child به text
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ShadButton.destructive(
        icon: const Icon(Icons.lock_reset_rounded, size: 18),
        onPressed: () {},
        text: const Text("Rotate Encryption Key"), // تغییر نام child به text
      ),
    );
  }
}
