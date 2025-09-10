class Slide {
  final int id;
  final String imageFile;
  final int status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imagePath;

  const Slide({
    required this.id,
    required this.imageFile,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.imagePath,
  });
}
