class MyProductFilterModel {
  final String? category;
  final String? brand;
  final String? size;
  final String? type;
  final String? material;
  final String? searchQuery;

  const MyProductFilterModel({
    this.category,
    this.brand,
    this.size,
    this.type,
    this.material,
    this.searchQuery,
  });

  Map<String, dynamic> toApiFilters([String? userId]) {
    final filters = <String, dynamic>{
      'user_id': userId ?? '', // Get from auth when calling this method
      'category_id': category,
      'brand_id': brand,
      'type_id': type,
      'material_id': material,
      'item_size': size,
      'search': searchQuery ?? '',
    };

    // Remove empty values
    filters.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );
    return filters;
  }

  bool get hasFilters =>
      category != null ||
      brand != null ||
      size != null ||
      type != null ||
      material != null ||
      searchQuery != null;

  MyProductFilterModel copyWith({
    String? category,
    String? brand,
    String? size,
    String? type,
    String? material,
    String? searchQuery,
  }) {
    return MyProductFilterModel(
      category: category ?? this.category,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      type: type ?? this.type,
      material: material ?? this.material,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  String toString() {
    return 'MyProductFilterModel(category: $category, brand: $brand, size: $size, type: $type, material: $material, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MyProductFilterModel &&
        other.category == category &&
        other.brand == brand &&
        other.size == size &&
        other.type == type &&
        other.material == material &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    return Object.hash(category, brand, size, type, material, searchQuery);
  }
}
