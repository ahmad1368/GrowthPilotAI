import 'package:growth_pilot_ai/core/data/repositories/product_form_draft_repository.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';

/// Loads the resumable draft into [fields] if one exists (Issue
/// #140, "Resume capability"). Returns whether a draft was found.
bool loadProductFormDraft(ProductFormDraftRepository draftRepo, ProductFormFields fields) {
  final draft = draftRepo.get();
  if (draft == null) return false;
  fields.loadFromDraft(draft);
  return true;
}
