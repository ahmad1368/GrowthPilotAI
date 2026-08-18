import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/generate_diagram_from_text.dart';
import 'package:growth_pilot_ai/core/models/generated_diagram.dart';

/// Drives the "Type or paste a text description" input (Issue #224).
class DiagramGenerationController extends GetxController {
  final result = Rxn<GeneratedDiagram>();

  void generate(String text) {
    if (text.trim().isEmpty) {
      result.value = null;
      return;
    }
    result.value = GenerateDiagramFromText.call(text);
  }
}
