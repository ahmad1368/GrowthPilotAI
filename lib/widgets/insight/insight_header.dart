// import 'package:flutter/material.dart';
// import '../../utils/ui_helper.dart';
// import 'insight_info_card.dart';

// class InsightHeader extends StatelessWidget {
//   final double total;

//   const InsightHeader({super.key, required this.total});

//   @override
//   Widget build(BuildContext context) {
//     if (UIHelper.isWide(context)) {
//       return Row(
//         children: [
//           Expanded(child: _buildMainCard()),
//           const SizedBox(width: 12),
//           Expanded(child: _buildAICard()),
//         ],
//       );
//     }
//     return _buildMainCard();
//   }

//   Widget _buildMainCard() => InsightInfoCard(
//         title: "مجموع هزینه",
//         value: "${total.toStringAsFixed(0)} \$",
//         icon: Icons.account_balance_wallet,
//         color: Colors.greenAccent,
//       );

//   Widget _buildAICard() => const InsightInfoCard(
//         title: "پیش‌بینی AI",
//         value: "در حال تحلیل...",
//         icon: Icons.psychology,
//         color: Colors.purpleAccent,
//       );
// }
