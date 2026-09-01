enum DocumentType {
  receipt(0, 'Receipt'),
  background(1, 'Background');

  final int id;
  final String label;
  
  const DocumentType(this.id, this.label);

  /// سازنده فکتوری برای تبدیل شناسه به انام
  factory DocumentType.fromId(int id) {
    return DocumentType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => DocumentType.background,
    );
  }
}