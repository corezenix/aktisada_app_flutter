import 'product_model.dart';

class ProductListResponse {
  final String message;
  final List<ProductModel> data;
  final bool status;

  const ProductListResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    // Handle the new nested structure: data.data contains the actual products
    final dataField = json['data'];
    List<ProductModel> products = [];
    
    if (dataField is Map<String, dynamic> && dataField['data'] is List<dynamic>) {
      // New structure: data.data contains products
      final productsList = dataField['data'] as List<dynamic>;
      products = productsList
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } else if (dataField is List<dynamic>) {
      // Old structure: data directly contains products
      products = dataField
          .map((product) => ProductModel.fromJson(product))
          .toList();
    }
    
    return ProductListResponse(
      message: json['message'] ?? '',
      data: products,
      status: json['status'] ?? false,
    );
  }
}
