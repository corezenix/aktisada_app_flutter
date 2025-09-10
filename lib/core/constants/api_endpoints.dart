class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://app.aktisada.com/api/v1';

  // Auth endpoints
  static const String login = '/login';
  static const String getUser = '/get-user';

  // Product endpoints
  static const String getSlides = '/get-slides';
  static const String getCategories = '/get-categories';
  static const String getBrandTypeMaterial = '/get-brand-type-material';
  static const String getFilters = '/get-filters';
  static const String addProduct = '/add-product';
  static const String addBrand = '/add-brand';
  static const String productList = '/product-list';
  static const String deleteProduct = '/delete-product';
  static const String editProduct = '/edit-product';
  static const String updateProduct = '/update-product';
  static const String productDetails = '/product-details';
  static const String getMyProducts = '/get-my-products';

  // Helper method to get full URL
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
