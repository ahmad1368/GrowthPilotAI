// import 'package:flutter/material.dart';
// import 'package:growth_pilot_ai/pages/insight_page.dart';
// import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
// import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';
// import '../../../core/data/entities/transaction_entity.dart';
// import '../../../core/data/repositories/transaction_repository.dart';
// // وارد کردن ویجت‌های اشتراکی پروژه

// class TransactionListScreen extends StatelessWidget {
//   final TransactionRepository repository;

//   const TransactionListScreen({
//     super.key,
//     required this.repository,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InsightPage(
//       title: 'مانیتورینگ زنده تراکنش‌ها',
//       icon: Icons.analytics_outlined, // آیکن متناسب با تحلیل‌های مالی پروژه
//       child: StreamBuilder<List<TransactionEntity>>(
//         // تزریق مستقیم تغییرات دیتابیس به UI
//         stream: repository.watchAll(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: AdaptiveText(
//                 'هیچ تراکنشی یافت نشد.',
//                 style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
//               ),
//             );
//           }

//           final items = snapshot.data!;

//           return LayoutBuilder(
//             builder: (context, constraints) {
//               // منطق تشخیص نمایشگر عریض (تبلت/دسکتاپ) طبق استانداردهای GrowthPilotAI
//               bool isWide = constraints.maxWidth > 600;

//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: OmniGlassPanel(
//                   backgroundColor: Colors.white.withValues(alpha: 0.08),
//                   child:
//                       isWide ? _buildWideTable(items) : _buildMobileList(items),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   /// طراحی اختصاصی برای نمایشگرهای معمولی موبایل
//   Widget _buildMobileList(List<TransactionEntity> items) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundColor: Colors.blue.withValues(alpha: 0.2),
//             child: Icon(Icons.payment_rounded,
//                 color: Colors.blue.withValues(alpha: 0.9), size: 20),
//           ),
//           title: AdaptiveText(
//             item.description,
//             style: const TextStyle(fontWeight: FontWeight.w600),
//           ),
//           subtitle: AdaptiveText(
//             item.date.toString().split(' ')[0], // نمایش فقط تاریخ
//             style: TextStyle(
//                 fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
//           ),
//           trailing: AdaptiveText(
//             '${item.amount} \$',
//             style: const TextStyle(
//                 color: Colors.greenAccent, fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }

//   /// طراحی اختصاصی برای نمایشگرهای عریض (Grid Layout)
//   Widget _buildWideTable(List<TransactionEntity> items) {
//     return GridView.builder(
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, // نمایش دو ستونه در نمای عریض
//         childAspectRatio: 4,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.black.withValues(alpha: 0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             children: [
//               Icon(Icons.receipt_long_rounded,
//                   color: Colors.blue.withValues(alpha: 0.7)),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AdaptiveText(item.description,
//                         style: const TextStyle(fontSize: 16)),
//                     AdaptiveText(item.date.toString(),
//                         style: const TextStyle(fontSize: 11)),
//                   ],
//                 ),
//               ),
//               AdaptiveText('${item.amount} \$',
//                   style: const TextStyle(color: Colors.greenAccent)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
