import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// The "Requirements List" preview page (Issue #259) — same detail as
/// #247's XLSX Requirements sheet, rendered as a printable table.
class BuildTraceabilityRequirementsPdfPage {
  static pw.Widget call(List<TraceableRequirementEntity> requirements) {
    return pw.TableHelper.fromTextArray(
      headers: ['Code', 'Description', 'Dev Status', 'MoSCoW Priority'],
      data: [
        for (final requirement in requirements)
          [
            requirement.reqCode,
            requirement.description,
            requirement.devStatus.name,
            requirement.moscowPriority?.name ?? '',
          ],
      ],
    );
  }
}
