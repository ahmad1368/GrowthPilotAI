class InsightModel {
  final int id;
  final String title;
  final String description;
  final String efficiency;
  // [Issue #837] Drives InsightCategoryStyle's icon/color per card.
  final String category;

  InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.efficiency,
    this.category = 'General',
  });

  // این متد فعلاً استفاده نمی‌شود ولی آماده برای API است
  factory InsightModel.fromJson(Map<String, dynamic> json) {
    return InsightModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      efficiency: json['efficiency'],
      category: json['category'] ?? 'General',
    );
  }
}
