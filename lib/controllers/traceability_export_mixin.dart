import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_export_subject.dart';
import 'package:growth_pilot_ai/business/build_last_modified_by_map.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_csv.dart';
import 'package:growth_pilot_ai/business/export_traceability_matrix_to_xlsx.dart';
import 'package:growth_pilot_ai/business/run_guarded_export.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/share_xlsx_bytes.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Structured Data Export (XLSX & CSV)" (Issue #245/#247), mixed into
/// `TraceabilityController` — must come after `TraceabilityCoverageMixin`
/// in the `with` clause so [coverageReport] is already available.
/// [isExportingMatrix] guards against duplicate taps and surfaces
/// failures via [RunGuardedExport] (Issue #254).
mixin TraceabilityExportMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  ExportEventRepository get exportEventRepository;
  Rxn<GoalCoverageReport> get coverageReport;

  final isExportingMatrix = false.obs;

  Future<void> exportMatrixToXlsx() =>
      RunGuardedExport.call(isExportingMatrix, 'XLSX', 'TraceabilityExportMixin', () async {
        final report = coverageReport.value;
        if (report == null) return;
        final bytes = ExportTraceabilityMatrixToXlsx.call(
          goals: goalList,
          requirements: requirementList,
          testCases: testCaseList,
          goalLinks: linkRepository.goalLinksFor(),
          testCaseLinks: linkRepository.allTestCaseLinks(),
          lastModifiedByRequirementId: BuildLastModifiedByMap.call(requirementList, historyRepository),
          coverageReport: report,
        );
        final now = DateTime.now();
        final filename = BuildTraceabilityExportFilename.call(now);
        await ShareXlsxBytes.call(bytes, filename,
            subject: BuildExportSubject.call('Traceability Matrix', timestamp: now));
        exportEventRepository.append(ExportEventEntity(
            format: 'xlsx', filename: filename, fileBytes: Uint8List.fromList(bytes), occurredAt: now));
      });

  Future<void> exportMatrixToCsv() =>
      RunGuardedExport.call(isExportingMatrix, 'CSV', 'TraceabilityExportMixin', () async {
        final csv = BuildTraceabilityMatrixCsv.call(
          goals: goalList,
          requirements: requirementList,
          testCases: testCaseList,
          goalLinks: linkRepository.goalLinksFor(),
          testCaseLinks: linkRepository.allTestCaseLinks(),
          lastModifiedByRequirementId: BuildLastModifiedByMap.call(requirementList, historyRepository),
        );
        final now = DateTime.now();
        final filename = BuildTraceabilityExportFilename.call(now, extension: 'csv');
        await ShareCsvBytes.call(csv, filename,
            subject: BuildExportSubject.call('Traceability Matrix', timestamp: now));
        exportEventRepository.append(ExportEventEntity(
            format: 'csv', filename: filename, fileBytes: Uint8List.fromList(utf8.encode(csv)), occurredAt: now));
      });
}
