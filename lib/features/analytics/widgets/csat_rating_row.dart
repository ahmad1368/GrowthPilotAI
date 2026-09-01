import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';

/// One logged CSAT rating row: date, score, and optional note (Issue #375).
class CsatRatingRow extends StatelessWidget {
  final CsatRatingEntity rating;

  const CsatRatingRow({super.key, required this.rating});

  String _date(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_date(rating.date),
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Expanded(
              child: Text(rating.note ?? '', overflow: TextOverflow.ellipsis)),
          Text('${rating.score}/5',
              style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
        ],
      ),
    );
  }
}
