/// [Issue #826] Two-level business-type model: a parent industry category
/// with its child subcategories, used by the profile's business-type
/// dropdowns.
class BusinessCategory {
  final String id;
  final String name;
  final List<BusinessSubcategory> children;

  const BusinessCategory({
    required this.id,
    required this.name,
    required this.children,
  });
}

class BusinessSubcategory {
  final String id;
  final String name;

  const BusinessSubcategory({required this.id, required this.name});
}
