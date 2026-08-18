import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/search_document_chunks.dart';
import 'package:growth_pilot_ai/core/models/document_search_result.dart';

/// Drives the "Hybrid Search" bar (Issue #230).
class DocumentSearchController extends GetxController {
  final results = <DocumentSearchResult>[].obs;
  final isSearching = false.obs;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      results.clear();
      return;
    }
    isSearching.value = true;
    try {
      results.assignAll(await SearchDocumentChunks.call(query));
    } finally {
      isSearching.value = false;
    }
  }
}
