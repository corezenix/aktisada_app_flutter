import 'product_model.dart';

class MyProductsResponse {
  final String message;
  final MyProductsData data;
  final bool status;

  const MyProductsResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory MyProductsResponse.fromJson(Map<String, dynamic> json) {
    return MyProductsResponse(
      message: json['message'] ?? '',
      data: MyProductsData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class MyProductsData {
  final int currentPage;
  final List<ProductModel> data;
  final String firstPageUrl;
  final int from;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;

  const MyProductsData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
  });

  factory MyProductsData.fromJson(Map<String, dynamic> json) {
    return MyProductsData(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((product) => ProductModel.fromJson(product))
              .toList() ??
          [],
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 10,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
    );
  }

  bool get hasNextPage => nextPageUrl != null;
  bool get hasPreviousPage => prevPageUrl != null;
}
