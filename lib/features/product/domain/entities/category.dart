class Category {
  final int id;
  final String category;
  final String imageFile;
  final int status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imagePath;

  const Category({
    required this.id,
    required this.category,
    required this.imageFile,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.imagePath,
  });
}
