class Type {
  final int id;
  final int categoryId;
  final String typeName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Type({
    required this.id,
    required this.categoryId,
    required this.typeName,
    required this.createdAt,
    required this.updatedAt,
  });
}
