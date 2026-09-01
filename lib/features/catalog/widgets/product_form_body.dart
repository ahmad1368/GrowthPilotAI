import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/load_product_form_draft.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_actions.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_view.dart';

/// Owns the Add/Edit Product form's widget state (Issue #140). No
/// NestJS/pre-signed URLs exist, so "upload" means generating a demo
/// photo via #139; drafts resume via ObjectBox instead of SQLCipher.
class ProductFormBody extends StatefulWidget {
  const ProductFormBody({super.key});
  @override
  State<ProductFormBody> createState() => _ProductFormBodyState();
}

class _ProductFormBodyState extends State<ProductFormBody> {
  final _repos = ProductFormRepos();
  final _fields = ProductFormFields();
  late final _actions = ProductFormActions(_repos, _fields);
  late final _resumedDraft = loadProductFormDraft(_repos.draft, _fields);
  int _step = 0;
  List<String> _errors = [];

  @override
  Widget build(BuildContext context) => ProductFormView(
        fields: _fields,
        resumedDraft: _resumedDraft,
        step: _step,
        errors: _errors,
        listings: _repos.listings.getAll(),
        callbacks: (
          onStepChanged: (s) => setState(() => _step = s),
          onTypeChanged: (t) => setState(() => _fields.type = t),
          onAddImage: () => setState(_actions.addImage),
          onRemoveImage: (id) => setState(() => _actions.removeImage(id)),
          onCleanupStaleImages: () => setState(_actions.cleanupStaleImages),
          onEditListing: (l) => setState(() {
            _fields.loadFromListing(l);
            _step = 0;
          }),
          onSubmit: () => setState(() => _errors = _actions.submit()),
        ),
      );
}
