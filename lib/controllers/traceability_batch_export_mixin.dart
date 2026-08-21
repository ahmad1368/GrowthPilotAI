import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_batch_export_files.dart';
import 'package:growth_pilot_ai/business/build_batch_export_zip_archive.dart';
import 'package:growth_pilot_ai/business/build_export_subject.dart';
import 'package:growth_pilot_ai/business/build_last_modified_by_map.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';
import 'package:growth_pilot_ai/business/notify_export_saved.dart';
import 'package:growth_pilot_ai/business/run_guarded_export.dart';
import 'package:growth_pilot_ai/business/share_zip_bytes.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Export all project-related artifacts... at once in a single ZIP
/// file" (Issue #258) — bundles the PDF report, XLSX matrix, and CSV
/// matrix into one in-memory `.zip` (see [BuildBatchExportZipArchive])
/// instead of the issue's Node.js `archiver`/BullMQ/S3 pipeline (no
/// backend exists in this repo; see PR notes). Mixed into
/// `TraceabilityController` after `TraceabilityPdfExportJobMixin`
/// (needs [buildReportPdfBytes]).
mixin TraceabilityBatchExportMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  ExportEventRepository get exportEventRepository;
  Rxn<GoalCoverageReport> get coverageReport;
  Future<Uint8List> buildReportPdfBytes();

  final isBatchExporting = false.obs;

  Future<void> exportBatchZip() =>
      RunGuardedExport.call(isBatchExporting, 'batch ZIP bundle', 'TraceabilityBatchExportMixin', () async {
        final report = coverageReport.value;
        if (report == null) return;

        final files = BuildBatchExportFiles.call(
          pdfBytes: await buildReportPdfBytes(),
          goals: goalList,
          requirements: requirementList,
          testCases: testCaseList,
          goalLinks: linkRepository.goalLinksFor(),
          testCaseLinks: linkRepository.allTestCaseLinks(),
          lastModifiedByRequirementId: BuildLastModifiedByMap.call(requirementList, historyRepository),
          coverageReport: report,
        );
        final zipBytes = BuildBatchExportZipArchive.call(files);

        final now = DateTime.now();
        final zipName = BuildTraceabilityExportFilename.call(now, extension: 'zip', baseName: 'Project_Bundle');
        await ShareZipBytes.call(zipBytes, zipName,
            subject: BuildExportSubject.call('Project Bundle', timestamp: now));

        final zipOut = Uint8List.fromList(zipBytes);
        exportEventRepository
            .append(ExportEventEntity(format: 'zip', filename: zipName, fileBytes: zipOut, occurredAt: now));
        await NotifyExportSaved.call(zipOut, zipName);
      });
}
