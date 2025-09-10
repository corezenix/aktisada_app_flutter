class Size {
  final int id;
  final int categoryId;
  final String itemSize;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Size({
    required this.id,
    required this.categoryId,
    required this.itemSize,
    required this.createdAt,
    required this.updatedAt,
  });
}
