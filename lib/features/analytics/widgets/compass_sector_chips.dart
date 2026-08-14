import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

/// Sector selector for the Business Compass (Issue #84) — Construction,
/// Tech, Retail, per the issue's "3 major BC sectors" acceptance criterion.
class CompassSectorChips extends StatelessWidget {
  final BusinessSector selected;
  final ValueChanged<BusinessSector> onChanged;

  const CompassSectorChips(
      {super.key, required this.selected, required this.onChanged});

  String _label(BusinessSector sector) {
    switch (sector) {
      case BusinessSector.construction:
        return 'Construction';
      case BusinessSector.tech:
        return 'Tech';
      case BusinessSector.retail:
        return 'Retail';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final sector in BusinessSector.values)
          ChoiceChip(
            label: Text(_label(sector)),
            selected: selected == sector,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(sector);
            },
          ),
      ],
    );
  }
}
