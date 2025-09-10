class Material {
  final int id;
  final int categoryId;
  final String materialName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Material({
    required this.id,
    required this.categoryId,
    required this.materialName,
    required this.createdAt,
    required this.updatedAt,
  });
}
