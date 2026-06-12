class InsightModel {
  final int id;
  final String title;
  final String description;
  final String efficiency;

  const InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.efficiency,
  });

  factory InsightModel.fromJson(Map<String, dynamic> json) {
    return InsightModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      efficiency: json['efficiency'] as String? ?? '0%',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'efficiency': efficiency,
    };
  }
}
